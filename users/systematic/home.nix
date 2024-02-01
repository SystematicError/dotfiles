{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.username = "systematic";
  home.homeDirectory = "/home/systematic";

  home.packages = with pkgs; [
    obsidian
    vesktop
    wireshark
    musescore

    steam
    prismlauncher
    cubiomes-viewer
    vinegar
    gamescope
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"]; # TODO: Fix later idiot

  imports = [
    ./modules/cli.nix
    ./modules/desktop.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gnome.nix
    ./modules/hyprland.nix
    ./modules/spicetify.nix
    ./modules/wezterm.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
