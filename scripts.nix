{
  home.file.".local/bin/upgrade.sh" = {
    source = ./scripts/upgrade.sh;
    executable = true;
  };
  home.file.".local/bin/switch.sh" = {
    source = ./scripts/switch.sh;
    executable = true;
  };
  home.file.".local/bin/install.sh" = {
    source = ./scripts/install.sh;
    executable = true;
  };
}
