#!/usr/bin/env bash
set -euo pipefail

FLAKE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Installing Home Manager ==="
nix run home-manager/master -- switch --flake "$FLAKE_DIR"

export PATH="$HOME/.nix-profile/bin:$PATH"

echo ""
echo "=== Deploying dotfiles ==="
dotter deploy -f -y

echo ""
echo "=== Installation complete ==="
echo "Open a new shell to apply changes."
