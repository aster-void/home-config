{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  myLib = import ./lib;
in {
  imports =
    [./packages.nix ./scripts.nix]
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

  home.sessionVariables = {
    NIX_PATH = "nixpkgs=${inputs.nixpkgs}";
  };

  systemd.user.sessionVariables = {
    NIX_PATH = lib.mkForce "nixpkgs=${inputs.nixpkgs}";
  };

  programs.ghostty = {
    enable = true;
    settings = {
      confirm-close-surface = false;
    };
  };
}
