#!/usr/bin/env bash
set -euo pipefail

echo "=== Updating DNF ==="
sudo dnf upgrade --refresh -y

echo ""
echo "=== Installing GPU Drivers ==="
sudo "$(which non-nixos-gpu-setup)"

echo ""
echo "=== Updating Firmware ==="
sudo fwupdmgr refresh --force
sudo fwupdmgr update -y
