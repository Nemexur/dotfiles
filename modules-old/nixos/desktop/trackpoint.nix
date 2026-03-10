{
  config,
  lib,
  ...
}: let
  cfg = config.modules.nixos-desktop.trackpoint;
in {
  options.modules.nixos-desktop.trackpoint = {
    enable = lib.mkEnableOption "TrackPoint Settings";
  };

  config = lib.mkIf cfg.enable {
    hardware.trackpoint = {
      enable = true;
      emulateWheel = true;
      sensitivity = 200;
      speed = 130;
      press_to_select = true;
    };
  };
}
