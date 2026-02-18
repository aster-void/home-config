# home-config

My home directory configuration, managed by [Home Manager](https://github.com/nix-community/home-manager) and [Dotter](https://github.com/SuperCuber/dotter).

## Setup

```sh
# Install Nix first: https://nixos.org/download
./scripts/install.sh
./scripts/install_system.sh  # Fedora only, requires sudo
```

## Scripts

- **`install.sh`** — Apply config changes (Home Manager + Dotter). No sudo required.
- **`install_system.sh`** — Desktop setup: dnf packages, `/etc/` deployment, shell, GPU drivers, WARP, Claude Desktop. Fedora only, requires sudo.
- **`upgrade.sh`** — Full system upgrade (dnf, flake, flatpak, firmware).
- **`undeploy.sh`** — Remove all Dotter-managed symlinks.

## Structure

- **`home-manager/`** — packages, session variables, services (Nix flake)
- **`dotter/`** — program configs deployed to `~/.config/`
- **`etc/`** — system-level config files
- **`scripts/`** — all scripts listed above
