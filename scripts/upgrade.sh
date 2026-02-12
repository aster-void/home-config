#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

echo "=== Updating DNF ==="
sudo dnf upgrade --refresh -y

echo ""
echo "=== Updating Home Manager Flake ==="
nix flake update --flake ./home-manager
switch.sh

echo ""
echo "=== Updating GPU Drivers ==="
sudo non-nixos-gpu-setup

echo ""
echo "=== Updating Flatpak ==="
flatpak update -y

echo ""
echo "=== Updating Firmware ==="
sudo fwupdmgr refresh --force
sudo fwupdmgr update -y

echo ""
echo "=== All updates complete ==="
