{
  lib,
  config,
  noctalia,
  ...
}: let
  cfg = config.home-modules.shell.noctalia;
in {
  imports = [
    noctalia.homeModules.default
  ];

  options.home-modules.shell.noctalia = {
    enable = lib.mkEnableOption "Enable NoctaliaShell";
  };

  config = lib.mkIf cfg.enable {
    programs.noctalia-shell.enable = true;

    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/home/nixos/noctalia/conf";
    in {
      "noctalia".source = mkSymlink configPath;
    };

    home.sessionVariables = {
      "NOCTALIA_PAM_SERVICE" = "greetd";
    };
  };
}
