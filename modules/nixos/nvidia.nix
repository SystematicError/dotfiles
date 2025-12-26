{config, ...}: {
  services.xserver.videoDrivers = ["amdgpu" "nvidia"];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      open = true;
      nvidiaSettings = true;

      modesetting.enable = true;

      # TODO: Enable Nvidia power management
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
}
