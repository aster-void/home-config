{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System

    ## Shell & Terminal Multiplexer
    fish
    starship
    tmux
    zellij
    ## Core utils
    ripgrep
    bat
    lsof
    dotter
    tree
    eza
    ## System info
    btop
    fastfetch
    nitch
    ## File management
    yazi
    fzf
    zoxide

    # Development

    ## Environment Loader
    direnv
    devenv
    nix-direnv
    mise
    ## Git and GitHub
    git
    gh
    ghq
    lefthook
    lazygit
    ## Editor
    helix
    ## LSP, MCP and Formatters
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
    mcp-nixos

    # Documents
    pandoc
  ];
}
