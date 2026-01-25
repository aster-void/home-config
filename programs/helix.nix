{
  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        bufferline = "multiple";
        true-color = true;
        rulers = [80 120];
        idle-timeout = 50;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
          character = "│";
        };

        statusline = {
          left = ["mode" "spinner" "file-name" "file-modification-indicator"];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-type"];
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        whitespace.render = {
          space = "none";
          tab = "all";
          newline = "none";
        };

        soft-wrap.enable = true;
      };

      keys = {
        normal = {
          space = {
            w = ":write";
            q = ":quit";
            c = ":buffer-close";
          };
          C-s = ":write";
          C-q = ":quit";
          esc = ["collapse_selection" "keep_primary_selection"];
        };

        insert = {
          C-s = ["normal_mode" ":write"];
        };
      };
    };

    languages = {
      language-server.nil = {
        command = "nil";
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt";
        }
      ];
    };
  };
}
