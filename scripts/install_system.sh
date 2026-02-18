#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

# Cache sudo credentials upfront and keep them alive in the background
sudo -v
while true; do sudo -v; sleep 60; done &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

# --- DNF packages ---
echo "=== Installing DNF packages ==="
sudo dnf install -y fish fuse-libs

# --- Shell setup ---
echo ""
echo "=== Setting up shell ==="
FISH_PATH=/usr/bin/fish
if ! grep -qx "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi
if [ "$SHELL" != "$FISH_PATH" ]; then
  sudo chsh -s "$FISH_PATH" "$USER"
fi

# --- /etc file deployment ---
echo ""
echo "=== Deploying /etc files ==="

MANIFEST="/etc/.home-config-managed"
current_files=$(cd etc && find . -type f | sed 's|^\./||' | sort)

if [[ -f "$MANIFEST" ]]; then
  while IFS= read -r old_file; do
    if ! echo "$current_files" | grep -qxF "$old_file"; then
      echo "Removing deleted file: /etc/$old_file"
      sudo rm -f "/etc/$old_file"
    fi
  done < "$MANIFEST"
fi

while IFS= read -r file; do
  sudo install -D -m 644 -o root -g root "etc/$file" "/etc/$file"
done <<< "$current_files"
sudo chmod 600 /etc/ssh/sshd_config

echo "$current_files" | sudo tee "$MANIFEST" > /dev/null

echo "Enabling services..."
sudo systemctl enable --now sshd avahi-daemon

echo "Restarting sshd..."
sudo sshd -t && sudo systemctl restart sshd

echo "Reloading sysctl..."
sudo sysctl --system > /dev/null

# --- Tailscale ---
echo ""
echo "=== Installing Tailscale ==="
if ! dnf repolist | grep -q tailscale; then
  sudo dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
fi
sudo dnf install -y tailscale
sudo systemctl enable --now tailscaled

# --- Cloudflare WARP ---
echo ""
echo "=== Installing Cloudflare WARP ==="
sudo dnf install -y cloudflare-warp

if ! warp-cli registration show &>/dev/null; then
  warp-cli --accept-tos registration new
  warp-cli --accept-tos connect
  echo "WARP registered and connected."
else
  echo "WARP already registered, skipping."
fi

# --- Claude Desktop ---
if ! flatpak run it.mijorus.gearlever --list-installed 2>/dev/null | grep -qi claude; then
  echo ""
  echo "=== Installing Claude Desktop (AppImage via GearLever) ==="
  APPIMAGE_URL=$(gh api repos/aaddrick/claude-desktop-debian/releases/latest \
    --jq '.assets[] | select(.name | test("amd64\\.AppImage$")) | .browser_download_url')
  if [ -z "$APPIMAGE_URL" ]; then
    echo "Warning: Could not find Claude Desktop AppImage release. Skipping."
  else
    TMPFILE=$(mktemp --suffix=.AppImage)
    curl -fL "$APPIMAGE_URL" -o "$TMPFILE"
    chmod +x "$TMPFILE"
    flatpak run it.mijorus.gearlever --integrate "$TMPFILE"
    rm -f "$TMPFILE"
    echo "Claude Desktop integrated via GearLever."
  fi
fi

# --- GPU drivers ---
if command -v non-nixos-gpu-setup &>/dev/null; then
  echo ""
  echo "=== Setting up non-NixOS GPU compatibility ==="
  sudo "$(command -v non-nixos-gpu-setup)"
  unit=/etc/systemd/system/non-nixos-gpu.service
  if [ -L "$unit" ]; then
    sudo cp --remove-destination "$(readlink -f "$unit")" "$unit"
    sudo systemctl daemon-reload
  fi
fi

echo ""
echo "=== System installation complete ==="
