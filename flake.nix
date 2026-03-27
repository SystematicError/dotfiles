{
  description = "My silly flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
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
    nix-darwin,
    ...
  } @ inputs: let
    mkNixosConfiguration = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs hostname;};
        modules = [./hosts/${hostname}/configuration.nix];
      };

    mkDarwinConfiguration = hostname:
      nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs;};
        modules = [./hosts/${hostname}/configuration.nix];
      };
  in {
    nixosConfigurations = {
      snowflake = mkNixosConfiguration "snowflake";
    };

    darwinConfigurations = {
      pie = mkDarwinConfiguration "pie";
    };
  };
}
