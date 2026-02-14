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

echo "=== /etc deployment complete ==="
