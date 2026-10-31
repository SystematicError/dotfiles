{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    fd
    lazygit
    ripgrep

    decibels
    easyeffects
    gnome-calculator
    gnome-clocks
    gnome-disk-utility
    gnome-font-viewer
    gnome-weather
    loupe
    packet
    papers
    pods
    resources
    showtime
    simple-scan
    snapshot

    gimp
    keepassxc
    obsidian
    onlyoffice-desktopeditors
    tutanota-desktop
    vesktop

    en-croissant
    prismlauncher
    steam
    steam-run
  ];

  imports = [
    ../../../../modules/home-manager/direnv.nix
    ../../../../modules/home-manager/eza.nix
    ../../../../modules/home-manager/firefox.nix
    ../../../../modules/home-manager/ghostty.nix
    ../../../../modules/home-manager/git.nix
    ../../../../modules/home-manager/gnome.nix
    ../../../../modules/home-manager/gtk.nix
    ../../../../modules/home-manager/nautilus.nix
    ../../../../modules/home-manager/nix-utils.nix
    ../../../../modules/home-manager/spicetify.nix
    ../../../../modules/home-manager/starship.nix
    ../../../../modules/home-manager/syncthing.nix
    ../../../../modules/home-manager/text-editor.nix
    ../../../../modules/home-manager/zed
    ../../../../modules/home-manager/zsh.nix
  ];

  home.stateVersion = "24.11";
}
