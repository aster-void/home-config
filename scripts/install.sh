#!/usr/bin/env bash
set -euo pipefail

cd ~/Workspace/github.com/aster-void/home-config

echo "=== Installing Home Manager ==="
nix run home-manager/master -- switch --flake ./home-manager

export PATH="$HOME/.nix-profile/bin:$PATH"

echo ""
echo "=== Deploying dotfiles ==="
dotter -g dotter/global.toml -l dotter/local.toml deploy -f -y

echo ""
echo "=== Installation complete ==="
echo "Open a new shell to apply changes."
