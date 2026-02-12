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
  ];
}
