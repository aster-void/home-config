{
  programs.fish = {
    enable = true;

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

      # Add standard paths for non-NixOS systems
      fish_add_path --path ~/.local/bin
      fish_add_path --path ~/.nix-profile/bin
      fish_add_path --path /usr/local/bin
      fish_add_path --path /usr/bin
      fish_add_path --path /bin

      starship init fish | source
    '';
  };
}
