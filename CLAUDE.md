# Home Manager Flake Notes

## Directory layout

```
.
├── home-manager/        # Home Manager flake
│   ├── flake.nix        # Flake entrypoint (per-host module selection)
│   ├── flake.lock
│   ├── home.nix         # Shared base config (username, paths, session vars)
│   └── modules/         # Individual modules imported per host
│       ├── packages.nix          # Common packages
│       ├── packages-desktop.nix  # Desktop-only packages
│       ├── syncthing.nix         # Syncthing service
│       ├── i18n.nix              # fcitx5 + hazkey
│       └── ghostty.nix           # Ghostty terminal
├── dotter/              # Dotter config + program configs
│   ├── global.toml      # File mappings (committed)
│   ├── local.toml       # Machine-specific package selection (gitignored)
│   └── config/          # Config files deployed to ~/.config
├── etc/                 # System-level config files (deployed manually to /etc/)
│   └── ssh/
│       └── sshd_config  # Hardened SSH daemon config
└── scripts/             # Shell scripts (install.sh, switch.sh, undeploy.sh, upgrade.sh, install_etc.sh)
```

## Commands

- **switch**: `switch.sh` — apply nix and config changes
- **upgrade**: `upgrade.sh` — full system upgrade (dnf, flake, flatpak, firmware)
- **undeploy**: `undeploy.sh` — remove all Dotter-managed symlinks
- **install**: `./scripts/install.sh` — fresh machine setup

## Architecture

- **Home Manager** handles package installation, session variables, and services
- **Dotter** handles config file deployment (symlinks from `dotter/config/` to `~/.config/`)
- Program configs live in `dotter/config/` — adding/editing files there and running `switch.sh` is all that's needed

## Working with this flake

- Use `git status`, not `git -C /home/aster/workspace/github.com/aster-void/home-config status`
- New `.nix` files must be `git add`ed before `home-manager switch` - flakes only see git-tracked files
- Each host profile in `flake.nix` explicitly imports its modules — add/remove modules there per host

## Adding programs

- **Common packages** → add to `home-manager/modules/packages.nix`
- **Desktop-only packages** → add to `home-manager/modules/packages-desktop.nix`
- **New module** → create in `home-manager/modules/`, then import it in the relevant hosts in `flake.nix`
- **Config files** → add to `dotter/config/` (deployed to `~/.config/` via Dotter)
- **System config** → add to `etc/` (deployed manually via `./scripts/install_etc.sh`, requires sudo)
- Don't assume packages exist in nixpkgs - search first, especially for proprietary/Linux-unsupported software that may require community flakes
