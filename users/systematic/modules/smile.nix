{pkgs, ...}: {
  home.packages = with pkgs; [
    smile
  ];

  dconf.settings = let
    basePath = "org/gnome/settings-daemon/plugins/media-keys";
  in {
    ${basePath}.custom-keybindings = [
      "/${basePath}/custom-keybindings/emoji/"
    ];

    "${basePath}/custom-keybindings/emoji" = {
      name = "Open emoji picker";
      command = "smile";
      binding = "<Super><Shift>e";
    };
  };
}
