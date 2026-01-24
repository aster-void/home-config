{ config, pkgs, lib, ... }:

{
  home.language = {
    base = "en_US.UTF-8";
    address = "ja_JP.UTF-8";
    collate = "ja_JP.UTF-8";
    ctype = "ja_JP.UTF-8";
    measurement = "ja_JP.UTF-8";
    messages = "en_US.UTF-8";
    monetary = "ja_JP.UTF-8";
    name = "ja_JP.UTF-8";
    numeric = "ja_JP.UTF-8";
    paper = "ja_JP.UTF-8";
    telephone = "ja_JP.UTF-8";
    time = "ja_JP.UTF-8";
  };

  services.hazkey.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
}
