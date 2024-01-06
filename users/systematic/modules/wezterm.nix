
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
    home.packages = with pkgs; [
        wezterm
        (writeShellScriptBin "xdg-terminal-exec" ''wezterm start "$@"'')
    ];
}
