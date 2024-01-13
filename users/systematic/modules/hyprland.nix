{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    hyprpaper
    rofi-wayland
    wl-clipboard
    # grimblast
    (callPackage ./grimblast_temp.nix {}) # Remove this after it gets merged into nixpkgs
    satty
    mako
    inputs.ags.packages.x86_64-linux.default
  ];

  home.file.hyprpaper = {
    target = ".config/hypr/hyprpaper.conf";
    text = ''
      ipc=off
      preload=${../assets/wallpaper.jpg}
      wallpaper=,${../assets/wallpaper.jpg}
    '';
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = ",preferred,auto,1";

      exec-once = [
        "hyprpaper"
        "mako"
        "hyprctl setcursor capitaine-cursors 24"
      ];

      env = [
        # "NIXOS_OZONE_WL,1"
        # "SLURP_ARGS,-b #000000aa -c #ffffffff -B #000000aa -w 1"
      ];

      general = {
        gaps_in = 8;
        gaps_out = 16;
        resize_on_border = true;
        "col.active_border" = "rgb(252525)";
        "col.inactive_border" = "rgb(252525)";
      };

      decoration = {
        rounding = 16;
        "col.shadow" = "rgba(00000000)";
      };

      master = {
        mfact = 0.5;
        new_is_master = false;
      };

      dwindle = {
        force_split = 2;
        smart_split = false;
        smart_resizing = false;
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

      bind =
        [
          "$mod ALT, q, exit"
          "$mod ALT, r, exec, hyprctl reload"

          "$mod, x, killactive"
          "$mod, f, togglefloating"
          "$mod, s, fullscreen"

          ", Print, exec, grimblast --freeze copy area"

          "$mod, space, exec, rofi -show drun"
          "$mod, Return, exec, wezterm"

          "$mod, mouse_up, workspace, e+1"
          "$mod, mouse_down, workspace, e-1"
        ]
        ++ builtins.concatLists (
          builtins.genList (key: let
            workspace =
              if key == 0
              then 10
              else key;
          in [
            "$mod, ${toString key}, workspace, ${toString workspace}"
            "$mod SHIFT, ${toString key}, movetoworkspacesilent, ${toString workspace}"
            "$mod CTRL, ${toString key}, movetoworkspace, ${toString workspace}"
          ])
          10
        );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
