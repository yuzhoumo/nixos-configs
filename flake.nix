{
  description = "NixOS system configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
      navi = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/navi ];
        specialArgs = { inherit inputs outputs; };
      };
    };

    # homeConfigurations = {
    #   "ppanda@navi" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #     extraSpecialArgs = { inherit inputs outputs; };
    #     modules = [ ./hosts/navi/home.nix ];
    #   };
    # };
  };
}
