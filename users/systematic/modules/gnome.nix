{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    appindicator
    blur-my-shell
    caffeine
    color-picker
    pano
    pip-on-top
    rounded-window-corners-reborn
  ];

  home.file.profile-picture = {
    source = ../assets/profile.png;
    target = ".face";
  };

  dconf.settings = {
    # Gnome core

    "org/gnome/desktop/background" = {
      picture-uri = "file://${../assets/wallpaper_light.png}";
      picture-uri-dark = "file://${../assets/wallpaper_dark.png}";
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
      apps = [];
      categories = [];
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
        "com.mitchellh.ghostty.desktop"
        "io.github.alainm23.planify.desktop"
        "obsidian.desktop"
        "steam.desktop"
        "org.prismlauncher.PrismLauncher.desktop"
        "spotify.desktop"
        "vesktop.desktop"
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
        "pip-on-top@rafostar.github.com"
        "rounded-window-corners@fxgn"
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

    "org/gnome/shell/extensions/pip-on-top" = {
      stick = true;
    };
  };
}
