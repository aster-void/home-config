# Home Manager Flake Notes

## Directory layout

```
.
├── flake.nix        # Flake entrypoint
├── home.nix         # Home Manager config root
├── packages.nix     # home.packages list
├── lib/             # Helper functions (collectFiles)
├── dotter/default/  # Program configs (deployed via dotter to ~/.config)
├── scripts/         # Shell scripts (install.sh, update.sh)
├── .dotter/         # Dotter config (global.toml)
└── services/        # Service modules (auto-imported via collectFiles)
```

## Commands

- **switch**: `git add -A -N && home-manager switch --flake .`
- **deploy configs**: `dotter deploy -f -y`
- **install (fresh machine)**: `./scripts/install.sh`

## Architecture

- **Home Manager** handles package installation, session variables, and services
- **Dotter** handles config file deployment (symlinks from `dotter/default/` to `~/.config/`)
- Program configs live in `dotter/default/` — adding/editing files there and running `dotter deploy` is all that's needed

## Working with this flake

- Working directory is already this repo - no need for `git -C`
- New `.nix` files must be `git add`ed before `home-manager switch` - flakes only see git-tracked files
- Files in `services/` are auto-imported via `myLib.collectFiles`

## Adding packages

- Packages go in `packages.nix`, config files go in `dotter/default/`
- Don't assume packages exist in nixpkgs - search first, especially for proprietary/Linux-unsupported software that may require community flakes
