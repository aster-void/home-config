#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

git add -A -N
nix run home-manager/master -- switch --flake ./home-manager
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" 2>/dev/null || true
export PATH="$HOME/.nix-profile/bin:$PATH"
dotter -g dotter/global.toml -l dotter/local.toml --cache-file dotter/.cache.toml deploy -f -y

# Claude Code (native binary, auto-updates on startup)
if ! command -v claude &>/dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
