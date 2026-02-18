#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

HOOK="per-host/$(hostname)/upgrade.sh"
if [[ -f "$HOOK" ]]; then
  echo "=== Running host-specific upgrade ==="
  bash "$HOOK"
  echo ""
fi

WARP_WAS_CONNECTED=0
if command -v warp-cli &>/dev/null && warp-cli status 2>/dev/null | grep -q "Connected"; then
  echo "=== Disconnecting from WARP ==="
  WARP_WAS_CONNECTED=1
  warp-cli disconnect
  echo ""
fi

echo "=== Updating Home Manager Flake ==="
nix flake update --flake ./home-manager
switch.sh

if [[ "$WARP_WAS_CONNECTED" == "1" ]]; then
  echo ""
  echo "=== Reconnecting to WARP ==="
  warp-cli connect
fi

echo ""
echo "=== Updating Flatpak ==="
flatpak update -y

echo ""
echo "=== All updates complete ==="
