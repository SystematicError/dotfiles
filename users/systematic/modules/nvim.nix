{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.frosty-vim.packages.${pkgs.system}.default
  ];

  home = {
    shellAliases.nv = "nvim";
    sessionVariables.EDITOR = lib.mkForce "nvim";
  };

  programs.git = {
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };
}
