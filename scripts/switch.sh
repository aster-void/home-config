#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

git add -A -N
nix run home-manager/master -- switch --flake ./home-manager
dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml deploy -f -y
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

HOOK="per-host/$(hostname)/switch.sh"
if [[ -f "$HOOK" ]]; then
  echo ""
  echo "=== Running host-specific switch ==="
  bash "$HOOK"
fi
