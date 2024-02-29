{...}: {
  home.sessionVariables.DIRENV_LOG_FORMAT = "";

  programs.direnv = {
    enable = true;

    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
