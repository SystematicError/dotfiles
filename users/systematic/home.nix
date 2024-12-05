{pkgs, ...}: {
  home.username = "systematic";
  home.homeDirectory = "/home/systematic";

  home.packages = with pkgs; [
    ripgrep
    yt-dlp
    curl

    obsidian
    gimp

    celluloid
    nautilus
    loupe
    resources
    easyeffects

    gnome-secrets

    gnome-text-editor
    warp
    libreoffice
    papers
    gnome-calculator
    gnome-font-viewer
    decibels
    gnome-clocks
    simple-scan
    snapshot

    steam
    steam-run

    prismlauncher
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./modules/desktop.nix
    ./modules/direnv.nix
    ./modules/eza.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gnome.nix
    ./modules/nvim.nix
    ./modules/spicetify.nix
    ./modules/starship.nix
    ./modules/vesktop.nix
    ./modules/wezterm.nix
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
