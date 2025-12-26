{
  config,
  hostname,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
  };

  programs.nh = {
    enable = true;
    flake = "/nixcfg";
  };
}
