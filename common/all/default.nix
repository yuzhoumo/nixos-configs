{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./environment.nix
    ./fonts.nix
    ./locale.nix
    ./nix.nix
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
}

