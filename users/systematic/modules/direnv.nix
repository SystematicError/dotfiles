{pkgs, ...}: {
  programs.direnv = {
    enable = true;

    package = pkgs.symlinkJoin {
      name = pkgs.direnv.name;
      paths = [pkgs.direnv];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''wrapProgram "$out/bin/direnv" --set DIRENV_LOG_FORMAT ""'';
    };

    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
