{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blueberry
    wl-clipboard
  ];
}
