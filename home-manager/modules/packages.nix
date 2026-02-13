{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # === System ===

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

    ## Data format and transform
    jq
    yq-go
    nushell

    # === Development ===

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

    ### Nix
    nixd
    nixfmt
    alejandra
    mcp-nixos

    ### Shell languages
    bash-language-server

    ### TS and web languages
    typescript-language-server
    typescript
    vscode-langservers-extracted
    tailwindcss-language-server
    prettier

    ### Data & Markup
    marksman
    taplo

    # === Documents ===
    pandoc
  ];
}
