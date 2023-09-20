# Host-specific system configurations for esper (desktop)

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
	../../common/all
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
      };
    };
  };

  networking = {
    hostName = "ghost";
    networkmanager.enable = true;
  };

  # Enable X11 windowing system
  services.xserver = {
    enable = true;

  #   displayManager = {
  #     defaultSession = "none+i3";
  #     sessionCommands = ''
		# xrandr --output DP-0 --mode 1920x1080 --rate 144
  #     '';  # Connect to primary 144hz monitor
  #   };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        i3lock  # Default i3 screen locker
        rofi    # Application launcher
      ];
    };

    # Configure X11 keymap
    layout = "us";
  };

  # Enable dconf
  programs.dconf.enable = true;

  # Define user account
  users.users.ppanda = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # Enable ‘sudo’ for the user.
	shell = pkgs.zsh;
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
  };

  system.stateVersion = "22.11";
}
