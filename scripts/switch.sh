#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

git add -A -N
home-manager switch --flake ./home-manager
dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml deploy -f -y
HOOK="per-host/$(hostname)/switch.sh"
if [[ -f "$HOOK" ]]; then
  echo ""
  echo "=== Running host-specific switch ==="
  bash "$HOOK"
fi
