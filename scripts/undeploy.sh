#!/usr/bin/env bash
set -euo pipefail

cd ~/Workspace/github.com/aster-void/home-config

dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml undeploy
