{pkgs, ...}: {
  # Broken
  # programs.zed-editor.extraPackages

  home.packages = with pkgs; [
    (writeShellScriptBin "zeditor-online" "NO_PROXY='*' ${zed-editor}/bin/zeditor --foreground --new")
  ];

  imports = [
    ./languages/bash.nix
    ./languages/haskell.nix
    ./languages/nix.nix
    ./languages/rust.nix
  ];

  programs.zed-editor = {
    enable = true;

    extensions = [
      "vercel-theme"
      "symbols"

      "biome"
      "csv"
      "docker-compose"
      "dockerfile"
      "git-firefly"
      "html"
      "html"
      "java"
      "latex"
      "lua"
      "make"
      "scss"
      "symbols"
      "toml"
      "toml"
      "vercel-theme"
      "xml"
    ];

    userSettings = {
      "proxy" = "socks5h://localhost:2";

      "disable_ai" = true;

      "collaboration_panel" = {
        "button" = false;
      };

      "telemetry" = {
        "diagnostics" = false;
        "metrics" = false;
      };

      "git" = {
        "inline_blame" = {
          "enabled" = false;
        };
      };

      "debugger" = {
        "dock" = "left";
      };

      "project_panel" = {
        "hide_root" = true;
      };

      "tabs" = {
        "file_icons" = true;
      };

      "title_bar" = {
        "show_sign_in" = false;
        "show_user_picture" = false;
        "show_branch_icon" = true;
      };

      "diagnostics" = {
        "inline" = {
          "enabled" = true;
        };
      };

      "inlay_hints" = {
        "show_background" = true;
        "enabled" = true;
      };

      "scrollbar" = {
        "show" = "system";
      };

      "relative_line_numbers" = "enabled";

      "show_signature_help_after_edits" = true;
      "auto_signature_help" = true;

      "sticky_scroll" = {
        "enabled" = true;
      };

      "buffer_line_height" = "standard";
      "ui_font_family" = ".SystemUIFont";
      "buffer_font_family" = "JetBrainsMono Nerd Font";
      "icon_theme" = "Symbols Icon Theme";
      "ui_font_size" = 16;
      "buffer_font_size" = 15;

      "vim_mode" = true;
      "base_keymap" = "VSCode";

      "theme" = {
        "mode" = "system";
        "light" = "Vercel Light";
        "dark" = "Vercel Dark";
      };
    };
  };
}
