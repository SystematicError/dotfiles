{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    tofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = ",preferred,auto,1";

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

      bind = [
        "$mod ALT, q, exit"
        "$mod ALT, r, exec, hyprctl reload"

        "$mod, space, exec, tofi-drun"
        "$mod, Return, exec, wezterm"
      ];
    };
  };
}
