#!/usr/bin/env bash
set -euo pipefail

echo "=== Updating DNF ==="
sudo dnf upgrade --refresh -y

echo ""
echo "=== Updating GPU Drivers ==="
sudo non-nixos-gpu-setup
