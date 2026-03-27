{...}: {
  programs.aerospace = {
    enable = true;
    # launchd.enable = true;

    settings = {
      config-version = 2;

      automatically-unhide-macos-hidden-apps = true;

      persistent-workspaces = [];

      gaps = {
        inner.horizontal = 5;
        inner.vertical = 5;
        outer.left = 5;
        outer.bottom = 5;
        outer.right = 5;
        outer.top = 5;
      };

      mode.main.binding = {
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
      };
    };
  };
}
