# home-config

My home directory configuration, managed by [Home Manager](https://github.com/nix-community/home-manager) and [Dotter](https://github.com/SuperCuber/dotter).

## Setup

```sh
# Install Nix first: https://nixos.org/download
./scripts/install.sh
```

## Usage

```sh
switch.sh   # Apply config changes
upgrade.sh  # Full system upgrade (dnf, flake, flatpak, firmware)
```

## Structure

- **Home Manager** — packages, session variables, services (`*.nix`)
- **Dotter** — program configs (`dotter/default/` → `~/.config/`)
- **Scripts** — `install.sh`, `switch.sh`, `upgrade.sh`
