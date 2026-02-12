#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

git add -A -N
home-manager switch --flake .
dotter -g dotter/global.toml -l dotter/local.toml deploy -f -y
