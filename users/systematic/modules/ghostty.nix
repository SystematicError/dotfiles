{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ghostty
    (writeShellScriptBin "xdg-terminal-exec" ''${pkgs.ghostty}/bin/ghostty -e "$@"'')
  ];

  home.file = {
    ghostty = {
      target = ".config/ghostty/config";

      text = lib.generators.toKeyValue {} {
        font-family = "JetBrainsMono Nerd Font";

        window-padding-x = 12;
        window-padding-y = 12;

        bold-is-bright = true;
        cursor-invert-fg-bg = true;
        unfocused-split-opacity = 1;
        window-theme = "system";
        theme = "light:custom-light,dark:custom-dark";
      };
    };

    ghostty-light-theme = {
      target = ".config/ghostty/themes/custom-light";

      text = lib.generators.toKeyValue {listsAsDuplicateKeys = true;} {
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

    ghostty-dark-theme = {
      target = ".config/ghostty/themes/custom-dark";

      text = lib.generators.toKeyValue {listsAsDuplicateKeys = true;} {
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
}
