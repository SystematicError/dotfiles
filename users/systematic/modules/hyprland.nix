{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    hyprpaper
    tofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = ",preferred,auto,1";

      exec-once = [
        "hyprpaper"
      ];

      general = {
        border_size = 0;
        gaps_in = 8;
        gaps_out = 16;
        resize_on_border = true;
      };

      decoration = {
        rounding = 16;
      };

      input = {
        kb_options = "caps:swapescape";
        accel_profile = "flat";
        follow_mouse = 2;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = false;
        };
      };

      "device:elan0718:00-04f3:30fd-touchpad" = {
        accel_profile = "";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 100;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        background_color = "#0f0f0f";
      };

      bind = [
        "$mod ALT, q, exit"
        "$mod ALT, r, exec, hyprctl reload"

        "$mod, space, exec, tofi-drun | xargs hyprctl dispatch exec --"
        "$mod, Return, exec, wezterm"
      ];
    };
  };
}
