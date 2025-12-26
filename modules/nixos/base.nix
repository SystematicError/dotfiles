{
  hostname,
  inputs,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  boot = {
    tmp.useTmpfs = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  hardware = {
    enableAllFirmware = true;

    cpu.amd.updateMicrocode = true;

    bluetooth.settings.General.Experimental = true;
  };

  environment = {
    sessionVariables.NH_FLAKE = "/nixcfg";

    systemPackages = with pkgs; [
      home-manager
      nh
    ];
  };
}
