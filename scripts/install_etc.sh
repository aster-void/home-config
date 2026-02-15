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

if ! command -v warp-cli &>/dev/null; then
  sudo rpm --import https://pkg.cloudflareclient.com/pubkey.gpg
  curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo
  sudo dnf install -y cloudflare-warp

  warp-cli registration new
  warp-cli connect
  echo "WARP installed and connected."
else
  echo "WARP already installed, skipping."
fi
