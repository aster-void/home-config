#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

git add -A -N
nix run home-manager/master -- switch --flake ./home-manager
dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml deploy -f -y
