{
  lib,
  config,
  ...
}: let
  cfg = config.modules.nixos-base.power;
in {
  options.modules.nixos-base.power = {
    enable = lib.mkEnableOption "Optimized Power Management";
  };

  config = lib.mkIf cfg.enable {
    services.tuned = {
      enable = true;
      settings.dynamic_tuning = true;
      ppdSupport = true;
      ppdSettings.main.default = "balanced";
    };
    services.upower.enable = true;
    services.power-profiles-daemon.enable = false;
    services.tlp.enable = false;
  };
}
