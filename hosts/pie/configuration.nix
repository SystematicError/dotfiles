{...}: {
  imports = [
    ./users.nix

    ../../modules/darwin/base.nix

    ../../modules/darwin/keyboard.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = "systematic";
  system.defaults.dock.persistent-apps = [
    "/Users/systematic/Applications/Home Manager Apps/Firefox.app"
    "/Users/systematic/Applications/Home Manager Apps/Ghostty.app"
    "/Users/systematic/Applications/Home Manager Apps/Zed.app"
    "/Users/systematic/Applications/Home Manager Apps/Obsidian.app"
    "/Users/systematic/Applications/Home Manager Apps/Vesktop.app"
    "/Users/systematic/Applications/Home Manager Apps/Spotify.app"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
