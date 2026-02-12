{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  home.packages = with pkgs; [
    blueberry
    wl-clipboard
  ];

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.discordapp.Discord"
    "com.usebottles.bottles"
    "it.mijorus.gearlever"
    "md.obsidian.Obsidian"
  ];
}
