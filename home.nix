{ config, pkgs, ... }:

let
  myLib = import ./lib;
in
{
  imports =
    [ ./packages.nix ]
    ++ myLib.collectFiles ./programs
    ++ myLib.collectFiles ./services;

  home.username = "aster";
  home.homeDirectory = "/home/aster";

  # You should not change this value, even if you update Home Manager.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  news.display = "silent";
}
