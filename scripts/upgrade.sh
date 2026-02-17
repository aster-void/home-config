#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

HOOK="per-host/$(hostname)/upgrade.sh"
if [[ -f "$HOOK" ]]; then
  echo "=== Running host-specific upgrade ==="
  bash "$HOOK"
  echo ""
fi

echo "=== Updating Home Manager Flake ==="
nix flake update --flake ./home-manager
switch.sh

echo ""
echo "=== Updating Flatpak ==="
flatpak update -y

echo ""
echo "=== All updates complete ==="
