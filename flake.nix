{
  description = "Unified NixOS configuration for both sasha and nasdvoya";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    unison-lang = {
      url = "github:ceedubs/unison-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      nixos-wsl,
      unison-lang,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
        overlays = [ unison-lang.overlay ];
      };
      pkgs-unstable = import nixpkgs-unstable {
        system = system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        sasha = lib.nixosSystem {
          system = system;
          modules = [
            ./hosts/sasha/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.sasha = import ./hosts/sasha/home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs pkgs pkgs-unstable;
                username = "sasha";
              };
            }
          ];
        };

        nasdvoya = lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/nasdvoya/configuration.nix
            nixos-wsl.nixosModules.wsl
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nasdvoya = import ./hosts/nasdvoya/home.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs pkgs pkgs-unstable;
                username = "nasdvoya";
              };
            }
          ];
        };
      };
    };
}
