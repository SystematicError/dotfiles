{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "xdg-terminal-exec" ''${pkgs.wezterm}/bin/wezterm start "$@"'')
  ];

  programs.wezterm = {
    enable = true;

    enableZshIntegration = true;

    extraConfig = let
      inline = lib.generators.mkLuaInline;
    in
      "return "
      + lib.generators.toLua {} {
        enable_wayland = false;

        # TODO: Remove when block rendering error is fixed
        front_end = "WebGpu";

        bold_brightens_ansi_colors = false;
        hide_tab_bar_if_only_one_tab = true;
        warn_about_missing_glyphs = false;

        xcursor_theme = config.gtk.cursorTheme.name;
        font = inline "wezterm.font 'JetBrainsMono Nerd Font'";

        window_padding = {
          left = 20;
          right = 20;
          top = 20;
          bottom = 20;
        };

        colors = {
          foreground = "#dddddd";
          background = "#0f0f0f";

          cursor_fg = "#0f0f0f";
          cursor_bg = "#dddddd";
          cursor_border = "#bababa";

          selection_fg = "#bababa";
          selection_bg = "#151515";

          split = "#303030";

          ansi = [
            "#1e1e1e"
            "#fc4e4e"
            "#bbef6e"
            "#ffaf60"
            "#6aa4cc"
            "#8d8bc4"
            "#96e0c9"
            "#bababa"
          ];

          brights = [
            "#303030"
            "#ff6565"
            "#c5ec8e"
            "#f6cd7e"
            "#82b4d6"
            "#ac9dcc"
            "#b8e5ec"
            "#dddddd"
          ];
        };
      };
  };
}
