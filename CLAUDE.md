# Home Manager Flake Notes

## Directory layout

```
.
├── home-manager/        # Home Manager flake
│   ├── flake.nix        # Flake entrypoint
│   ├── flake.lock
│   ├── home.nix         # Home Manager config root
│   ├── packages.nix     # home.packages list
│   ├── scripts.nix      # Script symlinks to ~/.local/bin
│   └── services/        # Service modules (auto-imported via collectFiles)
├── dotter/              # Dotter config + program configs
│   ├── global.toml      # File mappings (committed)
│   ├── local.toml       # Machine-specific package selection (gitignored)
│   └── config/          # Config files deployed to ~/.config
└── scripts/             # Shell scripts (install.sh, switch.sh, upgrade.sh)
```

## Commands

- **switch**: `switch.sh` — apply nix and config changes
- **upgrade**: `upgrade.sh` — full system upgrade (dnf, flake, flatpak, firmware)
- **install**: `./scripts/install.sh` — fresh machine setup

## Architecture

- **Home Manager** handles package installation, session variables, and services
- **Dotter** handles config file deployment (symlinks from `dotter/config/` to `~/.config/`)
- Program configs live in `dotter/config/` — adding/editing files there and running `switch.sh` is all that's needed

## Working with this flake

- Working directory is already this repo - no need for `git -C`
- New `.nix` files must be `git add`ed before `home-manager switch` - flakes only see git-tracked files
- Files in `home-manager/services/` are auto-imported via `collectFiles`

## Adding programs

- **Packages/programs** → add to `home-manager/packages.nix` (installed via Home Manager)
- **Config files** → add to `dotter/config/` (deployed to `~/.config/` via Dotter)
- Don't assume packages exist in nixpkgs - search first, especially for proprietary/Linux-unsupported software that may require community flakes
