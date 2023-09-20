# Host-specific system configurations for esper (desktop)

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
	../../common/all
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "intel_iommu=igfx_off" "nvidia-drm.modeset=1" ];

    loader = {
      systemd-boot.enable = true;        # Use systemd-boot EFI boot loader
      efi.canTouchEfiVariables = false;  # EFI read-only workaround
      grub.device = "/dev/sda";
    };

    supportedFilesystems = [ "ntfs" ];   # Enable NTFS support
  };

  networking = {
    hostName = "navi";
    networkmanager.enable = true;
  };

  hardware = {
    # Hardware OpenGL
    opengl.enable = true;
    opengl.extraPackages = [ pkgs.intel-compute-runtime ];

    # Nvidia drivers
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable X11 windowing system
  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    displayManager = {
      defaultSession = "none+i3";
      sessionCommands = ''
		xrandr --output DP-0 --mode 1920x1080 --rate 144
      '';  # Connect to primary 144hz monitor
    };

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

    # Nvidia Xserver settings
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option "AllowIndirectGLXProtocol" "off"
      Option "TripleBuffer" "on"
    '';
  };

  # Enable dconf
  programs.dconf.enable = true;

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound (pulseaudio)
  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
