{...}: {
  users.users = {
    systematic = {
      home = "/Users/systematic/";
    };
  };

  home-manager.users.systematic = ./home-manager/systematic/home.nix;
}
