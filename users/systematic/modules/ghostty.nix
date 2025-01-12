{pkgs, ...}: {
  home.packages = with pkgs; [
    ghostty
    (writeShellScriptBin "xdg-terminal-exec" ''${pkgs.ghostty}/bin/ghostty -e "$@"'')
  ];
}
