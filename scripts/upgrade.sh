#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(dirname "$0")"

echo "=== Updating DNF ==="
sudo dnf upgrade --refresh -y

echo ""
echo "=== Updating Home Manager Flake ==="
cd "$SCRIPT_DIR/.."
nix flake update
"$SCRIPT_DIR/switch.sh"

echo ""
echo "=== Updating Flatpak ==="
flatpak update -y

echo ""
echo "=== Updating Firmware ==="
sudo fwupdmgr refresh --force
sudo fwupdmgr update -y

echo ""
echo "=== All updates complete ==="
