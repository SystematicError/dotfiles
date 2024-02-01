{...}: {
  programs.git = {
    enable = true;

    userName = "SystematicError";
    userEmail = "systematicerror@users.noreply.github.com";

    aliases = {
      mpush = "push origin master";
      fmpush = "push --force origin master";
    };

    extraConfig = {
      safe = {
        directory = "/etc/nixos";
      };
    };
  };
}
