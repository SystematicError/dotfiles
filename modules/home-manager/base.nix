{username, ...}: {
  nixpkgs.config.allowUnfree = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    file.profile-picture = {
      source = ../../assets/${username}_profile.png;
      target = ".face";
    };
  };

  programs = {
    git.enable = true;
    home-manager.enable = true;
  };
}
