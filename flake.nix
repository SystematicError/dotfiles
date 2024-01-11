{
  description = "My silly flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    frosty-vim = {
      url = "github:SystematicError/frosty-vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-cascade = {
      url = "github:andreasgrafen/cascade/main";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    specialArgs = {inherit inputs outputs;};
    extraSpecialArgs = specialArgs;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    nixosConfigurations = {
      snowflake = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [./hosts/snowflake/configuration.nix];
      };
    };

    homeConfigurations = {
      "systematic@snowflake" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [./users/systematic/home.nix];
      };
    };
  };
}
