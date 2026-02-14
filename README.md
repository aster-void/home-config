# home-config

My home directory configuration, managed by [Home Manager](https://github.com/nix-community/home-manager) and [Dotter](https://github.com/SuperCuber/dotter).

## Setup

```sh
# Install Nix first: https://nixos.org/download
./scripts/install.sh
```

## Usage

```sh
switch.sh     # Apply config changes
undeploy.sh   # Remove all Dotter-managed symlinks
upgrade.sh    # Full system upgrade (dnf, flake, flatpak, firmware)
```

## System Config (`/etc`)

System-level config files live in `etc/` and must be deployed manually:

```sh
./scripts/install_etc.sh
```

This copies files to `/etc/` with correct ownership and permissions (requires sudo).

## Structure

- **`home-manager/`** — packages, session variables, services (Nix flake)
- **`dotter/`** — program configs (profiles) deployed to `~/.config/`
- **`etc/`** — system-level config files (deployed manually via `install_etc.sh`)
- **`scripts/`** — `install.sh`, `switch.sh`, `undeploy.sh`, `upgrade.sh`, `install_etc.sh`
