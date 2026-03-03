{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.home-modules.niri;
in {
  options.home-modules.niri = {
    enable = lib.mkEnableOption "Enable Niri";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.xwayland-satellite pkgs.wtype];

    programs.swaylock.enable = true;

    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/home/nixos/niri/conf";
    in {
      "niri".source = mkSymlink configPath;
    };
  };
}
