{ pkgs, ... }:

{
  program.home-manager.enable = true;

  home = {
    username = "ppanda";
    homeDirectory = "/home/ppanda";
    packages = with pkgs; [
      bitwarden
      deluge
      discord
	  feh
      firefox
      gimp
      gnome.nautilus
      neovim
      obsidian
      pavucontrol
      pcmanfm
      picom
      (polybar.override { i3Support = true; pulseSupport = true; })
      shotwell
      signal-desktop
      slack
      spotify
      tor-browser-bundle-bin
      vlc
    ];

	stateVersion = "22.11";
  };
}
