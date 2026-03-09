{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.nixos-desktop.fingerprint;
in {
  options.modules.nixos-desktop.fingerprint = {
    enable = lib.mkEnableOption "FingerPrint Reader";
  };

  config = lib.mkIf cfg.enable {
    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module
      };
    };
  };
}
