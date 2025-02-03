{
  description = "Unified NixOS configuration for both sasha and nasdvoya";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    unison-lang = {
      url = "github:ceedubs/unison-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    nixos-wsl,
    unison-lang,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = import nixpkgs {
      system = system;
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-7.0.410"
        "dotnet-runtime-6.0.36"
        "dotnet-core-combined"
        "dotnet-sdk-wrapped-6.0.428"
      ];
      overlays = [unison-lang.overlay];
    };
    pkgs-unstable = import nixpkgs-unstable {
      system = system;
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "dotnet-sdk-6.0.428"
        "dotnet-runtime-6.0.36"
        "dotnet-core-combined"
        "dotnet-sdk-wrapped-6.0.428"
      ];
    };
  in {
    homeConfigurations = {
      sasha = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/sasha/home.nix
          {
            home.username = "sasha";
            home.homeDirectory = "/home/sasha";
            programs.home-manager.enable = true;
          }
        ];
        extraSpecialArgs = {
          inherit inputs pkgs pkgs-unstable;
          username = "sasha";
        };
      };
    };
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
