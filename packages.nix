{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = with pkgs; [
    ripgrep
    bat
    ghq
    mcp-nixos
    lefthook
    alejandra
    pandoc
    inputs.claude-desktop.packages.${system}.claude-desktop
  ];
}
