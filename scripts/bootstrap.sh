#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

if ! command -v nix &>/dev/null; then
  echo "Error: nix is not installed. Install it first: https://nixos.org/download/"
  exit 1
fi

echo "=== Installing Home Manager ==="
nix run home-manager/master -- switch --flake ./home-manager

export PATH="$HOME/.nix-profile/bin:$PATH"

echo ""
bash scripts/switch.sh

echo ""
echo "=== Installation complete ==="
echo "Open a new shell to apply changes."
