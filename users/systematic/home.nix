{pkgs, ...}: {
  home.username = "systematic";
  home.homeDirectory = "/home/systematic";

  home.packages = with pkgs; [
    parsec-bin
    foliate

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
  ];

  nixpkgs.config.allowUnfree = true;

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

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
