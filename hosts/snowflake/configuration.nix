{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/auto-cpufreq.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/keyd.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/pipewire.nix
    ../../modules/nixos/printing.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  boot.tmp.useTmpfs = true;

  networking = {
    hostName = "snowflake";
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
    flatpak.enable = true;
  };

  hardware = {
    enableAllFirmware = true;

    cpu.amd.updateMicrocode = true;

    bluetooth.settings = {
      General = {
        Experimental = true;
      };
    };
  };

  programs = {
    zsh.enable = true;

    gamemode.enable = true;
  };

  virtualisation.podman = {
    enable = true;
    extraPackages = [pkgs.podman-compose];
  };

  users.groups.nixconf = {};

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      systematic = {
        isNormalUser = true;
        initialPassword = "nixos";
        extraGroups = ["wheel" "video" "audio" "networkmanager"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "24.11";
}
