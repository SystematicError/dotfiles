{
  lib,
  pkgs,
  ...
}: let
  ghosttyPackage =
    if pkgs.stdenv.isLinux
    then pkgs.ghostty
    else pkgs.ghostty-bin;
in {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    (writeShellScriptBin "xdg-terminal-exec" ''${ghosttyPackage}/bin/ghostty -e "$@"'')
  ];

  programs.ghostty = {
    enable = true;
    package = ghosttyPackage;

    settings = {
      font-family = "JetBrainsMono Nerd Font";

      window-padding-x = 12;
      window-padding-y = 12;

      bold-is-bright = true;
      cursor-invert-fg-bg = true;
      unfocused-split-opacity = 1;
      window-theme = "system";
      theme = "light:custom-light,dark:custom-dark";
    };

    themes = {
      custom-dark = {
        background = "#0f0f0f";
        foreground = "#dddddd";

        selection-background = "#151515";
        selection-foreground = "#bababa";

        palette = [
          "0=#1e1e1e"
          "1=#fc4e4e"
          "2=#bbef6e"
          "3=#ffaf60"
          "4=#6aa4cc"
          "5=#8d8bc4"
          "6=#96e0c9"
          "7=#bababa"

          "8=#303030"
          "9=#ff6565"
          "10=#c5ec8e"
          "11=#f6cd7e"
          "12=#82b4d6"
          "13=#ac9dcc"
          "14=#b8e5ec"
          "15=#dddddd"
        ];
      };

      custom-light = {
        background = "#0f0f0f";
        foreground = "#dddddd";

        selection-background = "#151515";
        selection-foreground = "#bababa";

        palette = [
          "0=#1e1e1e"
          "1=#fc4e4e"
          "2=#bbef6e"
          "3=#ffaf60"
          "4=#6aa4cc"
          "5=#8d8bc4"
          "6=#96e0c9"
          "7=#bababa"

          "8=#303030"
          "9=#ff6565"
          "10=#c5ec8e"
          "11=#f6cd7e"
          "12=#82b4d6"
          "13=#ac9dcc"
          "14=#b8e5ec"
          "15=#dddddd"
        ];
      };
    };
  };

  # HACK: Ghostty adds its store path to $PATH, tampering with Starship's nix shell heuristic
  programs.zsh.initContent = ''
    PATH=''${PATH//':${lib.replaceString "/" "\\/" ghosttyPackage.outPath}\/bin'/}
  '';
}
