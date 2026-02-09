{pkgs, ...}: {
  home.packages = with pkgs; [
    ripgrep
    bat
    ghq
    mcp-nixos
    lefthook
    alejandra
    pandoc
  ];
}
