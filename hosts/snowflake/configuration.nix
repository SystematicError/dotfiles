{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./users.nix

    ../../modules/nixos/base.nix

    ../../modules/nixos/auto-cpufreq.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/keyd.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/pipewire.nix
    ../../modules/nixos/printing.nix
  ];

  programs = {
    zsh.enable = true;
    gamemode.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  virtualisation.podman = {
    enable = true;
    extraPackages = [pkgs.podman-compose];
  };

  services.flatpak.enable = true;

  system.stateVersion = "24.11";
}
