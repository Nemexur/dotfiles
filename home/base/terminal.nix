{
  lib,
  pkgs,
  ...
}: {
  # Kitty for icat command
  programs.kitty.enable = true;

  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin
      then pkgs.hello # pkgs.ghostty is currently broken on darwin
      else pkgs.ghostty; # the stable version
    installBatSyntax = true;
    settings =
      {
        theme = "Dracula";
        font-family = "JetBrainsMono NF";
        font-size =
          if pkgs.stdenv.isDarwin
          then 15
          else 12;

        background-opacity = 0.8;
        background-blur = 8;

        macos-option-as-alt = true;
      }
      // (
        lib.optionals pkgs.stdenv.isx86_64
        {window-decoration = "none";}
      );
  };
}
