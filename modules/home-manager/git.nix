{pkgs, ...}: {
  programs.git = {
    enable = true;

    settings.safe.directory = "/etc/nixos";
  };
}
