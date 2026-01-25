# Home Manager Flake Notes

## Directory layout

```
.
├── flake.nix        # Flake entrypoint
├── home.nix         # Home Manager config root
├── packages.nix     # home.packages list
├── lib/             # Helper functions (collectFiles)
├── programs/        # Program modules (auto-imported)
└── services/        # Service modules (auto-imported)
```

## Commands

- **switch**: `git add -A -N && home-manager switch --flake .`

## Working with this flake

- Working directory is already this repo - no need for `git -C`
- New `.nix` files must be `git add`ed before `home-manager switch` - flakes only see git-tracked files
- Files in `programs/` and `services/` are auto-imported via `myLib.collectFiles`

## Adding packages

- Check if a home-manager module exists (e.g., `programs.mise`) before adding to `home.packages` - modules provide shell integration and proper activation
- Don't assume packages exist in nixpkgs - search first, especially for proprietary/Linux-unsupported software that may require community flakes
- Don't set options that are already defaults (e.g., `enableFishIntegration = true` when it's the default)
- If a module takes no arguments, it doesn't need to be a function - just use an attrset:
  ```nix
  # Good
  { programs.lazygit.enable = true; }

  # Unnecessary
  { ... }: { programs.lazygit.enable = true; }
  ```
