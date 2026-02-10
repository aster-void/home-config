{pkgs, ...}: {
  home.packages = with pkgs; [
    # Core utils
    ripgrep
    bat
    lsof

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
