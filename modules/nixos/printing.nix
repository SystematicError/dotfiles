{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.cnijfilter2];
  };

  hardware.sane.enable = true;

  # TODO: In depth printing config
}
