{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    corefonts
    nerd-fonts.jetbrains-mono
    adw-gtk3
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = {
      gtk-theme-name = "adw-gtk3";
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
}
