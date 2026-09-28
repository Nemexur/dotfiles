{
  flake.modules.homeManager.terminal = {pkgs, ...}: {
    # Kitty for icat command
    programs.kitty.enable = true;

    programs.foot = {
      enable = pkgs.stdenv.isLinux;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono NF:size=12";
          include = "${pkgs.foot.themes}/share/foot/themes/dracula";
          selection-target = "clipboard";
          pad = "12x12";
        };
        colors-dark.alpha = 0.8;
        scrollback = {
          lines = 20000;
          multiplier = 13.0;
        };
      };
    };

    programs.ghostty = {
      enable = true;
      package =
        if pkgs.stdenv.isDarwin
        then pkgs.brewCasks.ghostty
        else pkgs.ghostty;
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
          copy-on-select = "clipboard";
        }
        // (
          if pkgs.stdenv.isDarwin
          then {
            macos-option-as-alt = true;
            macos-auto-secure-input = true;
          }
          else {
            window-padding-x = 12;
            window-padding-y = 6;
            window-decoration = "auto";
            window-theme = "system";
            window-height = 26;
            window-width = 90;
            gtk-single-instance = false;
            gtk-titlebar = false;
            confirm-close-surface = false;
          }
        );
    };
  };
}
