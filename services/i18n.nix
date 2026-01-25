{lib, ...}: {
  services.hazkey.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };

  systemd.user.services.fcitx5-daemon.Install.WantedBy = lib.mkForce [];

  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
  };
}
