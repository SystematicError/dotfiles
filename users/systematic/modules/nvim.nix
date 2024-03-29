{
  inputs,
  lib,
  ...
}: {
  home.packages = [
    inputs.frosty-vim.packages.x86_64-linux.default
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
