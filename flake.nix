{
  description = "My silly flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    frosty-vim = {
      url = "github:SystematicError/frosty-vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:KaylorBen/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    mkNixosConfiguration = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs hostname;};

        modules = [
          ./hosts/${hostname}/configuration.nix
          ./hosts/${hostname}/hardware-configuration.nix
          ./hosts/${hostname}/users.nix
          ./modules/nixos/base.nix
        ];
      };

    mkHomeConfiguration = username: hostname: system:
      home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs username;};

        pkgs = nixpkgs.legacyPackages.${system};

        modules = [
          ./hosts/${hostname}/home-manager/${username}/home.nix
          ./modules/home-manager/base.nix
        ];
      };
  in {
    nixosConfigurations = {
      snowflake = mkNixosConfiguration "snowflake";
    };

    homeConfigurations = {
      "systematic@snowflake" = mkHomeConfiguration "systematic" "snowflake" "x86_64-linux";
    };
  };
}
