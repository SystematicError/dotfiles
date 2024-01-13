{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.spicetify.homeManagerModule];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with inputs.spicetify.packages.x86_64-linux.default.extensions; [
      adblock
      shuffle
    ];
  };
}
