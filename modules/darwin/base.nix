{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.home-manager.darwinModules.home-manager];

  nixpkgs.config.allowUnfree = true;

  nix = {
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    settings = {
      # auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
  };
}
