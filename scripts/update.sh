#!/usr/bin/env bash
set -euo pipefail

FLAKE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Updating DNF ==="
sudo dnf upgrade --refresh -y

echo ""
echo "=== Updating Home Manager Flake ==="
cd "$FLAKE_DIR"
nix flake update
git add -A -N
home-manager switch --flake .

echo ""
echo "=== Updating Flatpak ==="
flatpak update -y

echo ""
echo "=== Updating Firmware ==="
sudo fwupdmgr refresh --force
sudo fwupdmgr update -y

echo ""
echo "=== All updates complete ==="
