{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file.profile-picture = {
    source = ../../assets/${config.home.username}_profile.png;
    target = ".face";
  };

  home.packages = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    appindicator
    blur-my-shell
    caffeine
    launch-new-instance
    pip-on-top
  ];

  dconf.settings = {
    # Gnome core

    "org/gnome/desktop/background" = {
      picture-uri = "file://${../../assets/wallpaper_light.png}";
      picture-uri-dark = "file://${../../assets/wallpaper_dark.png}";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-format = "12h";
      clock-show-weekday = true;
      enable-hot-corners = false;
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      audible-bell = false;
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
      always-show-log-out = true;

      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "com.mitchellh.ghostty.desktop"
        "dev.zed.Zed.desktop"
        "md.obsidian.Obsidian.desktop"
        "tutanota-desktop.desktop"
        "vesktop.desktop"
        "spotify.desktop"
        "org.keepassxc.KeePassXC.desktop"
      ];
      disabled-extensions = [];
      enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "pip-on-top@rafostar.github.com"
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

    "org/gnome/shell/extensions/pip-on-top" = {
      stick = true;
    };
  };
}
