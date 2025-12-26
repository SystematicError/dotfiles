{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    neovide
    inputs.frosty-vim.packages.${pkgs.system}.neovim
  ];

  home = {
    shellAliases.nv = "nvim";
    sessionVariables.EDITOR = lib.mkForce "nvim";
  };

  programs.git.settings.core.editor = "nvim";
}
