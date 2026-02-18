#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

# Cache sudo credentials upfront and keep them alive in the background
sudo -v
while true; do sudo -v; sleep 60; done &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

# Manifest tracks deployed files as paths relative to /etc/, one per line.
# e.g. ssh/sshd_config
#      sysctl.d/50-inotify.conf
MANIFEST="/etc/.home-config-managed"

echo "=== Deploying /etc files ==="

# Determine current file set
current_files=$(cd etc && find . -type f | sed 's|^\./||' | sort)

# Remove files that were previously deployed but no longer exist in repo
if [[ -f "$MANIFEST" ]]; then
  while IFS= read -r old_file; do
    if ! echo "$current_files" | grep -qxF "$old_file"; then
      echo "Removing deleted file: /etc/$old_file"
      sudo rm -f "/etc/$old_file"
    fi
  done < "$MANIFEST"
fi

# Deploy current files
while IFS= read -r file; do
  sudo install -D -m 644 -o root -g root "etc/$file" "/etc/$file"
done <<< "$current_files"
sudo chmod 600 /etc/ssh/sshd_config

# Write new manifest
echo "$current_files" | sudo tee "$MANIFEST" > /dev/null

echo "Restarting sshd..."
sudo sshd -t && sudo systemctl restart sshd

echo "Reloading sysctl..."
sudo sysctl --system > /dev/null

echo "=== /etc deployment complete ==="

if command -v dnf &>/dev/null; then
  echo ""
  echo "=== Installing Cloudflare WARP ==="

  sudo dnf install -y cloudflare-warp

  if ! warp-cli registration show &>/dev/null; then
    warp-cli registration new
    warp-cli connect
    echo "WARP registered and connected."
  else
    echo "WARP already registered, skipping."
  fi
fi
