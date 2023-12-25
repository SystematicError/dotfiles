{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    corefonts
    inter
    (nerdfonts.override {fonts = ["JetBrainsMono"];})

    adw-gtk3
    capitaine-cursors

    blackbox-terminal
    celluloid
    easyeffects
    gnome.gnome-weather
    gnome.nautilus
    gnome-text-editor
    loupe
    mission-center

    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.color-picker
    gnomeExtensions.pano
    gnomeExtensions.rounded-window-corners

    (writeShellScriptBin "xdg-terminal-exec" ''eval $(echo "blackbox -c \"$@\"")'')
  ];

  home.file.profile-picture = {
    source = ../assets/profile.png;
    target = ".face";
  };

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

  services.easyeffects = {
    enable = true;
    preset = "configured";
  };

  dconf.settings = {
    # Gnome core

    "org/gnome/desktop/background" = {
      picture-uri = "file://${../assets/wallpaper.jpg}";
      picture-uri-dark = "file://${../assets/wallpaper.jpg}";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-format = "12h";
      enable-hot-corners = false;
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      audible-bell = false;
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = ["caps:swapescape"];
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      click-method = "areas";
      disable-while-typing = false;
      tap-to-click = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      excluded-apps = ["org.gnome.Loupe.desktop"];
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/gnome-session" = {
      logout-prompt = false;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
      night-light-schedule-from = 1.0;
      night-light-schedule-to = 1.0;
      night-light-temperature = lib.hm.gvariant.mkUint32 4170;
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "com.raggesilver.BlackBox.desktop"
        "obsidian.desktop"
        "org.prismlauncher.PrismLauncher.desktop"
      ];
      disabled-extensions = [];
      enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "color-picker@tuberry"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "pano@elhan.io"
        "rounded-window-corners@yilozt"
      ];
    };

    # Gnome extensions

    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.50;
      sigma = 45;
    };

    "org/gnome/shell/extensions/caffeine" = {
      enable-fullscreen = false;
      toggle-shortcut = ["<Shift><Super>c"];
    };

    "org/gnome/shell/extensions/color-picker" = {
      enable-systray = false;
      enable-shortcut = true;
      color-picker-shortcut = ["<Shift><Super>x"];
    };

    "org/gnome/shell/extensions/pano" = {
      open-links-in-browser = false;
      play-audio-on-copy = false;
      send-notification-on-copy = false;
      session-only-mode = true;
      show-indicator = false;
    };

    # Applications

    "com/raggesilver/BlackBox" = {
      notify-process-completion = false;
      terminal-bell = false;
      theme-bold-is-bright = true;
      font = "JetBrainsMono Nerd Font 12";
      scrollback-lines = lib.hm.gvariant.mkUint32 2500;
      terminal-padding = lib.hm.gvariant.mkTuple (map (size: lib.hm.gvariant.mkUint32 size) [15 15 15 15]);
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
      sort-directories-first = true;
    };

    "org/gnome/nautilus/preferences" = {
      show-create-link = true;
      show-delete-permanently = true;
    };

    "org/gnome/TextEditor" = {
      indent-style = "space";
      tab-width = lib.hm.gvariant.mkUint32 4;
    };
  };
}
