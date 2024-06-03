{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../common/all
    ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "offworld";
    networkmanager.enable = true;
  };

  users.users.ppanda = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # user packages
    ];
  };

  services = {
    openssh = {
      enable = true;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ... ];
      enable = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

