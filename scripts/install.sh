#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

echo "=== Installing Home Manager ==="
nix run home-manager/master -- switch --flake ./home-manager

export PATH="$HOME/.nix-profile/bin:$PATH"

echo ""
echo "=== Deploying dotfiles ==="
dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml deploy -f -y

HOOK="per-host/$(hostname)/install.sh"
if [[ -f "$HOOK" ]]; then
  echo ""
  echo "=== Running host-specific install ==="
  bash "$HOOK"
fi

echo ""
echo "=== Installation complete ==="
echo "Open a new shell to apply changes."
