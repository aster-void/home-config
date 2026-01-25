{
  programs.fish = {
    enable = true;

    shellInit = ''
      fish_add_path --prepend ~/.local/bin
    '';

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      l = "ls -CF";
      ".." = "cd ..";
      "..." = "cd ../..";
      g = "git";
      gs = "git status";
      gsv = "git diff --cached";
      gd = "git diff";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      lg = "lazygit";
      h = "hx";
      claude = "claude --dangerously-skip-permissions";
      home = "home-manager";
    };

    interactiveShellInit = ''
      set -g fish_greeting
      starship init fish | source
    '';
  };
}
