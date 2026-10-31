{pkgs, ...}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    extraPackages = [pkgs.podman-compose];
  };
}
