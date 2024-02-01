{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    corefonts
    inter
    (nerdfonts.override {fonts = ["JetBrainsMono"];})

    adw-gtk3
    capitaine-cursors
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    font = {
      name = "Inter";
      size = 11;
      package = pkgs.inter;
    };

    cursorTheme = {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
