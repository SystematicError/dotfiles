{...}: {
  users.users = {
    systematic = {
      isNormalUser = true;
      initialPassword = "nixos";
      extraGroups = ["wheel" "video" "audio" "networkmanager"];
    };
  };

  home-manager.users.systematic = ./home-manager/systematic/home.nix;
}
