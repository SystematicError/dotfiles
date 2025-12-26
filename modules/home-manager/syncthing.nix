{pkgs, ...}: {
  home.packages = with pkgs.gnomeExtensions; [
    syncthing-indicator
  ];

  services.syncthing.enable = true;

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
