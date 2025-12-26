{
  inputs,
  pkgs,
  ...
}: {
  home.username = "systematic";
  home.homeDirectory = "/home/systematic";

  home.file.profile-picture = {
    source = ../../../../assets/profile.png;
    target = ".face";
  };

  programs.git = {
    enable = true;

    settings.user = {
      name = "SystematicError";
      email = "systematicerror@users.noreply.github.com";
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    curl
    fd
    nix-inspect
    ripgrep
    yt-dlp

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

    obsidian
    gimp
    libreoffice
    keepassxc

    steam
    prismlauncher
    steam-run

    (writeShellScriptBin "dementia" ''
      exec ${bubblewrap}/bin/bwrap \
        --ro-bind / / \
        --dev-bind /dev /dev \
        --bind /proc /proc \
        --bind /sys /sys \
        --bind /run /run \
        --overlay-src /home --tmp-overlay /home \
        --overlay-src /tmp --tmp-overlay /tmp \
        -- \
        "''${@:-$SHELL}"
    '')

    (writeShellScriptBin "nix-flake-use-system-nixpkgs" ''
      nix flake lock --override-input nixpkgs github:NixOS/nixpkgs/${inputs.nixpkgs.rev} "$@"
    '')

    (writeShellScriptBin "nix-flake-update-inputs-using-system-nixpkgs" ''
      nix flake update --override-input nixpkgs github:NixOS/nixpkgs/${inputs.nixpkgs.rev} "$@"
    '')
  ];

  imports = [
    ../../../../modules/home-manager/direnv.nix
    ../../../../modules/home-manager/eza.nix
    ../../../../modules/home-manager/firefox.nix
    ../../../../modules/home-manager/foliate.nix
    ../../../../modules/home-manager/ghostty.nix
    ../../../../modules/home-manager/gnome.nix
    ../../../../modules/home-manager/gtk.nix
    ../../../../modules/home-manager/nautilus.nix
    ../../../../modules/home-manager/nvim.nix
    ../../../../modules/home-manager/smile.nix
    ../../../../modules/home-manager/spicetify.nix
    ../../../../modules/home-manager/starship.nix
    ../../../../modules/home-manager/syncthing.nix
    ../../../../modules/home-manager/text_editor.nix
    ../../../../modules/home-manager/vesktop.nix
    ../../../../modules/home-manager/zsh.nix
  ];

  home.stateVersion = "24.11";
}
