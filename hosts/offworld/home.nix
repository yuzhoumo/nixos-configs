{ pkgs, ... }:

{
  program.home-manager.enable = true;

  home = {
    username = "ppanda";
    homeDirectory = "/home/ppanda";
    packages = with pkgs; [
    ];

    stateVersion = "24.05";
  };
}
