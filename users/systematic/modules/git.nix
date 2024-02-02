{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.writeShellScriptBin "git" ''TZ=UTC ${pkgs.git}/bin/git "$@"'';

    userName = "SystematicError";
    userEmail = "systematicerror@users.noreply.github.com";

    aliases = {
      mpush = "push origin master";
      fmpush = "push --force origin master";
    };

    extraConfig = {
      core = {
        editor = "nvim";
      };

      safe = {
        directory = "/etc/nixos";
      };
    };
  };
}
