#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

# Cache sudo credentials upfront and keep them alive in the background
sudo -v
while true; do sudo -v; sleep 60; done &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

if ! command -v nix &>/dev/null; then
  echo "Error: nix is not installed. Install it first: https://nixos.org/download/"
  exit 1
fi

echo "=== Installing Home Manager ==="
nix run home-manager/master -- switch --flake ./home-manager

export PATH="$HOME/.nix-profile/bin:$PATH"

echo ""
bash scripts/switch.sh

if ! command -v /usr/bin/fish &>/dev/null; then
  echo "=== Installing fish ==="
  sudo dnf install -y fish
fi
FISH_PATH=/usr/bin/fish
if ! grep -qx "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi
if [ "$SHELL" != "$FISH_PATH" ]; then
  echo "=== Setting default shell to fish ==="
  chsh -s "$FISH_PATH"
fi

if command -v non-nixos-gpu-setup &>/dev/null; then
  echo ""
  echo "=== Installing GPU Drivers ==="
  sudo "$(command -v non-nixos-gpu-setup)"
  unit=/etc/systemd/system/non-nixos-gpu.service
  if [ -L "$unit" ]; then
    sudo cp --remove-destination "$(readlink -f "$unit")" "$unit"
    sudo systemctl daemon-reload
  fi
fi

echo ""
echo "=== Installation complete ==="
echo "Open a new shell to apply changes."
