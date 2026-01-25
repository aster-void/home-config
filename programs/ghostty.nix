{pkgs, ...}: {
  home.packages = [pkgs.ghostty];

  xdg.configFile."ghostty/config" = {
    text = ''
      confirm-close-surface = false
    '';
    force = true;
  };
}
