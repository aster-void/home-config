{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  home.packages = with pkgs; [
    blueberry
    wl-clipboard
  ];

  systemd.user.services.flatpak-managed-install.Service.TimeoutStartSec = "10m";

  services.flatpak.enable = true;
  services.flatpak.remotes = lib.mkOptionDefault [
    {
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }
  ];
  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.discordapp.Discord"
    "com.slack.Slack"
    "com.github.tchx84.Flatseal"
    "com.google.ChromeDev"
    "com.usebottles.bottles"
    "com.valvesoftware.Steam"
    "it.mijorus.gearlever"
    "md.obsidian.Obsidian"
    "org.gnome.eog"
  ];
}
