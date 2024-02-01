{
  inputs,
  pkgs,
  ...
}: {
  home.username = "systematic";
  home.homeDirectory = "/home/systematic";

  home.packages = with pkgs; [
    eza
    ripgrep
    yt-dlp
    curl
    inputs.frosty-vim.packages.x86_64-linux.default

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
    ./modules/desktop.nix
    ./modules/direnv.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gnome.nix
    ./modules/hyprland.nix
    ./modules/spicetify.nix
    ./modules/starship.nix
    ./modules/wezterm.nix
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
