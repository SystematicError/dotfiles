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
    # TODO: Remove this later once I've setup nvim
    alejandra
    vscodium

    obsidian
    vesktop
    wireshark
    musescore

    steam
    prismlauncher
    cubiomes-viewer
    # vinegar
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"]; # TODO: Fix later idiot

  imports = [
    ./modules/cli.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gnome.nix
  ];

  home.file.frosty-vim = {
    target = ".config/nvim/lua/package_list.lua";
    source = inputs.frosty-vim.packageList;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
