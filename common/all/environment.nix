{ pkgs, ... }:

{
  programs.zsh.enable = true;

  environment = {
    # Environement variables
    variables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # Default packages installed system-wide
    systemPackages = with pkgs; [
      gcc
      glibc
      clang
      htop
      git
      bat
      kitty
      killall
      nano
      neovim
      zip
      unzip
      wget
      tmux
      python3
    ];
  };
}
