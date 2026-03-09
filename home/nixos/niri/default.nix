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
    home.packages = with pkgs; [
      xwayland-satellite
      wtype
      swaylock
    ];

    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/home/nixos/niri/conf";
    in {
      "niri".source = mkSymlink configPath;
    };
  };
}
