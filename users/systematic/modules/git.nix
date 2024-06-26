{pkgs, ...}: {
  programs.git = {
    enable = true;

    package = pkgs.symlinkJoin {
      inherit (pkgs.git) name meta;

      paths = [pkgs.git];
      nativeBuildInputs = [pkgs.makeWrapper];

      postBuild = ''wrapProgram "$out/bin/git" --set TZ UTC'';
    };

    userName = "SystematicError";
    userEmail = "systematicerror@users.noreply.github.com";

    aliases = {
      mpush = "push origin master";
      fmpush = "push --force origin master";
    };

    extraConfig.safe = {
      directory = "/etc/nixos";
    };
  };
}
