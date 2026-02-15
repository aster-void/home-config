#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

MANIFEST="/etc/.home-config-managed"

echo "=== Deploying /etc files ==="

# Determine current file set
current_files=$(cd etc && find . -type f | sed 's|^\./|/etc/|' | sort)

# Remove files that were previously deployed but no longer exist in repo
if [[ -f "$MANIFEST" ]]; then
  while IFS= read -r old_file; do
    if ! echo "$current_files" | grep -qxF "$old_file"; then
      echo "Removing deleted file: $old_file"
      sudo rm -f "$old_file"
    fi
  done < "$MANIFEST"
fi

# Deploy current files
sudo cp -r etc/* /etc/

# Write new manifest
echo "$current_files" | sudo tee "$MANIFEST" > /dev/null

# Fix permissions and owners
sudo chown root:root /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/sshd_config

echo "Restarting sshd..."
sudo sshd -t && sudo systemctl restart sshd

echo "Reloading sysctl..."
sudo sysctl --system

echo "=== /etc deployment complete ==="

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
