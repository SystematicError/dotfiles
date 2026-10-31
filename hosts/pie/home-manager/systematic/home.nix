{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    fd
    lazygit
    ripgrep

    keepassxc
    obsidian

    en-croissant
  ];

  # TODO: Is this needed?
  targets.darwin.linkApps.enable = false;
  targets.darwin.copyApps.enable = true;

  imports = [
    ../../../../modules/home-manager/direnv.nix
    ../../../../modules/home-manager/eza.nix
    ../../../../modules/home-manager/firefox.nix
    ../../../../modules/home-manager/ghostty.nix
    ../../../../modules/home-manager/git.nix
    ../../../../modules/home-manager/nix-utils.nix
    ../../../../modules/home-manager/spicetify.nix
    ../../../../modules/home-manager/starship.nix
    # ../../../../modules/home-manager/syncthing.nix
    ../../../../modules/home-manager/zed
    ../../../../modules/home-manager/zsh.nix
  ];

  home.stateVersion = "24.11";
}
