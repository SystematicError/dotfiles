{...}: {
  programs.git = {
    enable = true;

    settings.user = {
      name = "SystematicError";
      email = "systematicerror@users.noreply.github.com";
    };
  };
}
