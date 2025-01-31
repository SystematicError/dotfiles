{pkgs, ...}: {
  home.username = "systematic";
  home.homeDirectory = "/home/systematic";

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    curl
    ripgrep
    yt-dlp

    celluloid
    decibels
    easyeffects
    foliate
    gnome-calculator
    gnome-clocks
    gnome-font-viewer
    gnome-secrets
    loupe
    nautilus
    papers
    resources
    simple-scan
    snapshot
    warp

    obsidian
    gimp
    libreoffice

    steam
    steam-run
    parsec-bin
  ];

  imports = [
    ./modules/direnv.nix
    ./modules/eza.nix
    ./modules/firefox.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/gnome.nix
    ./modules/gtk.nix
    ./modules/nvim.nix
    ./modules/planify.nix
    ./modules/prism.nix
    ./modules/smile.nix
    ./modules/spicetify.nix
    ./modules/starship.nix
    ./modules/text_editor.nix
    ./modules/vesktop.nix
    ./modules/zsh.nix
  ];

  home.stateVersion = "23.05";
}
