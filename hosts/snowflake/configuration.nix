{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
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
    kernelParams = [
      "split_lock_detect=off"
    ];

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
    xserver = {
      enable = true;

      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      videoDrivers = ["nvidia"];
      excludePackages = [pkgs.xterm];
    };

    gnome.core-utilities.enable = false;
    power-profiles-daemon.enable = false;

    printing = {
      enable = true;
      drivers = [pkgs.cnijfilter2];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    auto-cpufreq = {
      enable = true;

      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };

        charger = {
          governor = "balanced";
          turbo = "auto";
        };
      };
    };
  };

  documentation.nixos.enable = false;
  environment.gnome.excludePackages = [pkgs.gnome-tour];

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;

  hardware = {
    enableAllFirmware = true;

    cpu.amd.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      open = true;
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;

      modesetting.enable = true;

      powerManagement = {
        enable = false;
        finegrained = true;
      };

      prime = {
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  programs.zsh.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.gamemode.enable = true;

  users.groups.wireshark = {};
  security.wrappers.dumpcap = {
    source = "${pkgs.wireshark}/bin/dumpcap";
    capabilities = "cap_net_raw,cap_net_admin+eip";
    owner = "root";
    group = "wireshark";
    permissions = "u+rx,g+x";
  };

  virtualisation.podman.enable = true;

  users.groups.nixconf = {};
  systemd.tmpfiles.rules = [
    "d /etc/nixos 0775 root nixconf"
  ];

  users = {
    defaultUserShell = pkgs.zsh;

    users = {
      systematic = {
        isNormalUser = true;
        initialPassword = "nixos";
        extraGroups = ["wheel" "video" "audio" "networkmanager" "wireshark" "nixconf"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = "23.05";
}
