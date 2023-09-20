{ pkgs, inputs, ... }:

{
  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  nix = {  # Nix Package Manager settings
    settings.auto-optimise-store = true;  # Optimize syslinks
    gc = {                                # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
    '';
  };
}
