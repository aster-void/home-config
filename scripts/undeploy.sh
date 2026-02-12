#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml undeploy
