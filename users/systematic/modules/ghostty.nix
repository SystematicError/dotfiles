{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ghostty
    (writeShellScriptBin "xdg-terminal-exec" ''${pkgs.ghostty}/bin/ghostty -e "$@"'')
  ];

  home.file.ghostty = let
    valueToString = value:
      if builtins.isBool value
      then lib.boolToString value
      else toString value;

    setToConfig = set:
      lib.concatStrings (builtins.attrValues (builtins.mapAttrs (key: value: "${key}=${valueToString value}\n") set));
  in {
    target = ".config/ghostty/config";
    text = setToConfig {
      font-family = ''"JetBrainsMono Nerd Font"'';

      bold-is-bright = true;
      cursor-invert-fg-bg = true;
      unfocused-split-opacity = 1;

      window-padding-x = 12;
      window-padding-y = 12;

      background = "0f0f0f";
      foreground = "dddddd";

      selection-foreground = "bababa";
      selection-background = "151515";

      "palette=0" = "1e1e1e";
      "palette=1" = "fc4e4e";
      "palette=2" = "bbef6e";
      "palette=3" = "ffaf60";
      "palette=4" = "6aa4cc";
      "palette=5" = "8d8bc4";
      "palette=6" = "96e0c9";
      "palette=7" = "bababa";

      "palette=8" = "303030";
      "palette=9" = "ff6565";
      "palette=10" = "c5ec8e";
      "palette=11" = "f6cd7e";
      "palette=12" = "82b4d6";
      "palette=13" = "ac9dcc";
      "palette=14" = "b8e5ec";
      "palette=15" = "dddddd";
    };
  };
}
