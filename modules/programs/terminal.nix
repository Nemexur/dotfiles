{
  flake.modules.homeManager.terminal = {pkgs, ...}: {
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
        }
        // (
          if pkgs.stdenv.isDarwin
          then {
            macos-option-as-alt = true;
          }
          else {
            window-padding-x = 12;
            window-padding-y = 6;
            window-decoration = "auto";
            window-theme = "system";
            window-height = 26;
            window-width = 90;
            copy-on-select = true;
            gtk-single-instance = false;
            gtk-titlebar = false;
            confirm-close-surface = false;
          }
        );
    };
  };
}
