{
  home.file = builtins.listToAttrs (map (name: {
      name = ".local/bin/${name}";
      value = {
        source = ../scripts/${name};
        executable = true;
      };
    }) [
      "upgrade.sh"
      "switch.sh"
      "install.sh"
    ]);
}
