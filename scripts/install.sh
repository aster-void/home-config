#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

echo "=== Installing Home Manager ==="
nix run home-manager/master -- switch --flake ./home-manager

export PATH="$HOME/.nix-profile/bin:$PATH"

echo ""
echo "=== Deploying dotfiles ==="
dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml deploy -f -y

echo ""
echo "=== Installing Flatpak apps ==="
flatpak install --user -y flathub \
  app.zen_browser.zen \
  com.discordapp.Discord \
  com.usebottles.bottles \
  it.mijorus.gearlever \
  md.obsidian.Obsidian

echo ""
echo "=== Installation complete ==="
echo "Open a new shell to apply changes."
