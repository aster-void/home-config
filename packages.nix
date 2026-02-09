{pkgs, ...}: {
  home.packages = with pkgs; [
    # Core utils
    ripgrep
    bat

    # Development
    ghq
    lefthook
    mcp-nixos
    alejandra

    # Documents
    pandoc

    # Desktop
    blueberry
  ];
}
