{...}: {
  users.users = {
    systematic = {
      isNormalUser = true;
      initialPassword = "nixos";
      extraGroups = ["wheel" "video" "audio" "networkmanager"];
    };
  };
}
