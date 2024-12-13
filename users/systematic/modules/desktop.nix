{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    corefonts
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    /*
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    */

    font = {
      name = "Inter";
      size = 11;
      package = pkgs.inter;
    };

    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
