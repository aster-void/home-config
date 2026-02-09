{
  lib,
  pkgs,
  ...
}: {
  services.hazkey.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-qt
    ];
  };

  systemd.user.services.fcitx5-daemon.Install.WantedBy = lib.mkForce [];

  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
  };
}
