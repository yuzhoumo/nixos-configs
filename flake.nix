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
    lib = nixpkgs.lib // home-manager.lib;
  in {
    inherit lib;

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {

	  # Virtual Machine
      ghost = lib.nixosSystem {
        modules = [ ./hosts/ghost ];
        specialArgs = { inherit inputs outputs; };
      };

      # Desktop
      navi = lib.nixosSystem {
        modules = [ ./hosts/navi ];
        specialArgs = { inherit inputs outputs; };
      };

	  # TODO: Macbook
      # spinner = nixpkgs.lib.nixosSystem {
      #   modules = [ ./hosts/spinner ];
      #   specialArgs = { inherit inputs outputs; };
      # };

	  # TODO: Home Server
      # offworld = nixpkgs.lib.nixosSystem {
      #   modules = [ ./hosts/offworld ];
      #   specialArgs = { inherit inputs outputs; };
      # };

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

