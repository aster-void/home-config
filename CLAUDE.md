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
└── scripts/             # Shell scripts (install.sh, install_system.sh, upgrade.sh, undeploy.sh)
```

## Commands

- **install**: `install.sh` — apply nix and config changes (no sudo, idempotent)
- **install_system**: `install_system.sh` — desktop setup: dnf packages, /etc, shell, GPU, WARP, Claude Desktop (sudo, Fedora-specific)
- **upgrade**: `upgrade.sh` — full system upgrade (dnf, flake, flatpak, firmware)
- **undeploy**: `undeploy.sh` — remove all Dotter-managed symlinks

## Call tree

```
upgrade.sh ─→ install.sh
```

## Architecture

- **Home Manager** handles installing things only: native packages, flatpak apps, fonts, services. Do NOT use it for text configuration (e.g. `xdg.mimeApps`, program settings)
- **Dotter** handles all text/config file deployment (symlinks from `dotter/config/` to `~/.config/`)
- Program configs live in `dotter/config/` — adding/editing files there and running `install.sh` is all that's needed

## Working with this flake

- Use `git status`, not `git -C /home/aster/workspace/github.com/aster-void/home-config status`
- New `.nix` files must be `git add`ed before `home-manager switch` - flakes only see git-tracked files
- Each host profile in `flake.nix` explicitly imports its modules — add/remove modules there per host

## Adding programs

- **Common packages** → add to `home-manager/modules/packages.nix`
- **Desktop-only packages** → add to `home-manager/modules/packages-desktop.nix`
- **New module** → create in `home-manager/modules/`, then import it in the relevant hosts in `flake.nix`
- **Config files** → add to `dotter/config/` (deployed to `~/.config/` via Dotter)
- **System config** → add to `etc/` (deployed via `./scripts/install_system.sh`, requires sudo)
- Don't assume packages exist in nixpkgs - search first, especially for proprietary/Linux-unsupported software that may require community flakes
