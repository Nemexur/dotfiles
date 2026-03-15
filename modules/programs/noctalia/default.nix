{
  flake.modules.homeManager.noctalia = {config, pkgs, ...}: {
    home.packages = with pkgs.unstable; [
      wl-clipboard
      wf-recorder
    ];

    programs.noctalia-shell.enable = true;

    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/modules/programs/noctalia/_conf";
    in {
      "noctalia".source = mkSymlink configPath;
    };

    home.sessionVariables = {
      "NOCTALIA_PAM_SERVICE" = "greetd";
    };
  };
}
