#!/usr/bin/env bash
set -euo pipefail

cd ~/Workspace/github.com/aster-void/home-config

git add -A -N
home-manager switch --flake ./home-manager
dotter -g dotter/global.toml -l dotter/local.toml deploy -f -y
