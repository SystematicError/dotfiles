{
  pkgs,
  lib,
  ...
}: {
  services.syncthing.enable = true;

  home.packages =
    lib.optional pkgs.stdenv.isLinux
    pkgs.gnomeExtensions.syncthing-indicator;

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "syncthing@gnome.2nv2u.com"
      ];
    };

    "org/gnome/shell/extensions/syncthing" = {
      auto-start-item = false;
    };
  };
}
