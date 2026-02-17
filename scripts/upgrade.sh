#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

echo "=== Updating Home Manager Flake ==="
nix flake update --flake ./home-manager
switch.sh

echo ""
echo "=== Updating Flatpak ==="
flatpak update -y

echo ""
echo "=== Updating Firmware ==="
sudo fwupdmgr refresh --force
sudo fwupdmgr update -y

HOOK="per-host/$(hostname)/upgrade.sh"
if [[ -f "$HOOK" ]]; then
  echo ""
  echo "=== Running host-specific upgrade ==="
  bash "$HOOK"
fi

echo ""
echo "=== All updates complete ==="
