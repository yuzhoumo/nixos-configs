{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    corefonts              # MS fonts
    font-awesome           # Icons
    (nerdfonts.override {  # Nerd fonts
      fonts = [ "Hack" ];
    })
  ];
}
