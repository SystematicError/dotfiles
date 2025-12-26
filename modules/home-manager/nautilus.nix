{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    nautilus
    nautilus-python
    ffmpegthumbnailer
  ];

  gtk.gtk3.bookmarks = [
    "file://${config.home.homeDirectory}/Downloads"
    "file://${config.home.homeDirectory}/Documents"
    "file://${config.home.homeDirectory}/Documents/Notes"
    "file://${config.home.homeDirectory}/Documents/Books"
    "file://${config.home.homeDirectory}/Pictures"
    "file://${config.home.homeDirectory}/Videos"
    "file://${config.home.homeDirectory}/Music"
    "file:/// Root"
  ];

  home.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";

  dconf.settings = {
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
      sort-directories-first = true;
    };

    "org/gnome/nautilus/preferences" = {
      show-create-link = true;
      show-delete-permanently = true;
    };
  };
}
