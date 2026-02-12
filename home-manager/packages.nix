{pkgs, ...}: {
  home.packages = with pkgs; [
    # Core utils
    ripgrep
    bat
    lsof
    dotter

    # Development
    ghq
    lefthook
    mcp-nixos
    alejandra

    # Documents
    pandoc

    # Desktop
    blueberry
    wl-clipboard
    fastfetch

    # Programs (managed via dotter configs)
    fish
    ghostty
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
