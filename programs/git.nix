{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "aster-void";
        email = "137767097+aster-void@users.noreply.github.com";
      };
      alias = {
        aa = "add -A";
        amend = "commit --amend --no-edit";
        recommit = "commit --amend";
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        lg = "log --oneline --graph --decorate";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      ghq.root = "~/workspace";
    };
  };
}
