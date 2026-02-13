{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core utils
    ripgrep
    bat
    lsof
    dotter
    tree

    # Development
    devenv
    gh
    ghq
    lefthook
    mcp-nixos

    # LSP & Formatters
    nil
    nixfmt
    typescript-language-server
    typescript
    vscode-langservers-extracted
    tailwindcss-language-server
    marksman
    taplo
    bash-language-server
    prettier

    # Documents
    pandoc

    # System info
    fastfetch
    nitch

    # File management & listing
    eza
    yazi

    # Programs (managed via dotter configs)
    fish
    git
    helix
    lazygit
    fzf
    direnv
    nix-direnv
    mise
    starship
    zoxide
    zellij
  ];
}
