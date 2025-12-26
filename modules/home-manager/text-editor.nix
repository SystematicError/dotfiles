{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnome-text-editor
  ];

  dconf.settings."org/gnome/TextEditor" = {
    restore-session = false;
    indent-style = "space";
    tab-width = lib.hm.gvariant.mkUint32 4;
  };
}
