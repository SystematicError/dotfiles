{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    foliate
  ];

  dconf.settings."com/github/johnfactotum/Foliate/viewer/font".default-size = lib.hm.gvariant.mkUint32 18;
}
