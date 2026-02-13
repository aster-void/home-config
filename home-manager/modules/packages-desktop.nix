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
    "com.google.ChromeDev"
    "com.usebottles.bottles"
    "com.valvesoftware.Steam"
    "it.mijorus.gearlever"
    "md.obsidian.Obsidian"
  ];
}
