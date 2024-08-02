{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixpkgs-unstable, ... }: 
    let 
      system ="x86_64-linux";
      lib = nixpkgs.lib;
      # pkgs = nixpkgs.legacyPackages.${system};
      # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { system = system; config.allowUnfree = true; };   
      username = "sasha";
    in
  {
    nixosConfigurations = {
        ${username} = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/sasha/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./hosts/${username}/home.nix;
	    home-manager.extraSpecialArgs = { 
              inherit inputs;
              inherit username;
              inherit pkgs-unstable;
              inherit pkgs;
            };

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
