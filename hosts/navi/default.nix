# Host-specific system configurations for esper (desktop)

{ config, pkgs, ... }:

{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true; # Use the systemd-boot EFI boot loader.
      efi.canTouchEfiVariables = false; # Fix read-only issue
      grub.device = "/dev/sda";
    };

    kernelParams = [ "intel_iommu=igfx_off" "nvidia-drm.modeset=1" ];
    supportedFilesystems = [ "ntfs" ]; # Enable NTFS support
  };

  networking = {
    hostName = "navi";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Los_Angeles";

  programs.dconf.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  hardware = {
    opengl.enable = true; # Hardware OpenGL
    opengl.extraPackages =  [ pkgs.intel-compute-runtime ];
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; # Nvidia drivers
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      sessionCommands = ''
    	xrandr --output DP-0 --mode 1920x1080 --rate 144
      '';
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        i3lock   # default i3 screen locker
        rofi     # application launcher
      ];
    };

    layout = "us"; # Configure X11 keymap


    # NVidia xserver settings
    videoDrivers = [ "nvidia" ];

    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option "AllowIndirectGLXProtocol" "off"
      Option "TripleBuffer" "on"
    '';
  };

  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs.config.allowUnfree = true; # Allow unfree packages
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.steam.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ppanda = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      bitwarden
      deluge
      discord
      firefox
      gimp
      kitty
      obsidian
      obs-studio
      signal-desktop
      slack
      spicetify-cli
      spotify
      tor-browser-bundle-bin
      vlc
      zoom-us
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    feh
    git
    gnome.nautilus
    htop
    killall
    neovim
    nodejs
    pavucontrol
    pcmanfm
    (polybar.override { i3Support = true; pulseSupport = true; })
    picom
    python3
    shotwell
    tmux
    unzip
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
