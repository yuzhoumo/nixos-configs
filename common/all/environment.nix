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
      bat
      clang
      gcc
      git
      glibc
      htop
      killall
      kitty
      nano
      neovim
      python3
      tmux
      tree
      unzip
      wget
      zip
    ];
  };
}
