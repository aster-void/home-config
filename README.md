# home-config

My home directory configuration, managed by [Home Manager](https://github.com/nix-community/home-manager) and [Dotter](https://github.com/SuperCuber/dotter).

## Setup

```sh
# Install Nix first: https://nixos.org/download
./scripts/bootstrap.sh
```

## Scripts

- **`bootstrap.sh`** — First-time setup. Checks prerequisites (`git`, `nix`, `flatpak`), runs `switch.sh`, installs fish as default shell, and sets up GPU drivers.
- **`switch.sh`** — Apply config changes (Home Manager, Dotter, Claude Desktop). Day-to-day command.
- **`upgrade.sh`** — Full system upgrade (dnf, flake, flatpak, GPU drivers).
- **`undeploy.sh`** — Remove all Dotter-managed symlinks.
- **`install_etc.sh`** — Deploy `etc/` to `/etc/` (requires sudo).

## Structure

- **`home-manager/`** — packages, session variables, services (Nix flake)
- **`dotter/`** — program configs deployed to `~/.config/`
- **`etc/`** — system-level config files
- **`scripts/`** — all scripts listed above
