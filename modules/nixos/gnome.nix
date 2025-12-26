{pkgs, ...}: {
  documentation.nixos.enable = false;
  environment.gnome.excludePackages = [pkgs.gnome-tour];

  services = {
    gnome.core-apps.enable = false;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
    };
  };
}
