{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl.url = "github:guibou/nixGL";
    sops-nix.url = "github:Mic92/sops-nix";
    #sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        config.permittedInsecurePackages = [ "electron-25.9.0" ];
        overlays = [ nixgl.overlay ];
    };
    in {
      homeConfigurations = {
        "sasha" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/sasha/home.nix ];
          extraSpecialArgs = { inherit inputs; };
          
          # to pass through arguments to home.nix
        };
      };
    };
}
