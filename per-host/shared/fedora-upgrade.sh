#!/usr/bin/env bash
set -euo pipefail

echo "=== Updating DNF ==="
sudo dnf upgrade --refresh -y

echo ""
echo "=== Updating Firmware ==="
sudo fwupdmgr refresh --force
sudo fwupdmgr update -y
