{
  config,
  pkgs,
  ...
}: let
  myLib = import ./lib;
in {
  imports =
    [./packages.nix]
    ++ myLib.collectFiles ./programs
    ++ myLib.collectFiles ./services;

  home.username = "aster";
  home.homeDirectory = "/home/aster";

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.nix-profile/bin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
  ];

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable XDG integration for non-NixOS Linux
  targets.genericLinux.enable = true;

  nixpkgs.config.allowUnfree = true;

  news.display = "silent";
}
