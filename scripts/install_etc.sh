#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

echo "=== Deploying /etc files ==="

sudo cp -r etc/* /etc/

sudo chown root:root /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/sshd_config

echo "Validating sshd config..."
sudo sshd -t

echo "Restarting sshd..."
sudo systemctl restart sshd

echo "Reloading sysctl..."
sudo sysctl --system

echo "=== /etc deployment complete ==="

echo ""
echo "=== Installing Cloudflare WARP ==="

sudo dnf install -y cloudflare-warp

if ! warp-cli registration show &>/dev/null; then
  warp-cli registration new
  warp-cli connect
  echo "WARP registered and connected."
else
  echo "WARP already registered, skipping."
fi
