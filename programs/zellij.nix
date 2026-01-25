{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "catppuccin-mocha";
      default_shell = "fish";

      copy_command = "wl-copy";
      copy_on_select = true;
      scrollback_editor = "hx";

      pane_frames = true;
      simplified_ui = false;

      mouse_mode = true;
      scroll_buffer_size = 10000;

      default_layout = "compact";

      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };

      keybinds = {
        unbind = ["Ctrl g"];
      };
    };
  };
}
