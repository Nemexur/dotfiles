{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  dms,
  dms-plugin-registry,
  ...
}: let
  cfg = config.modules.nixos-desktop.dms;
in {
  imports = [
    dms-plugin-registry.modules.default
    "${pkgs-unstable.path}/nixos/modules/programs/wayland/dms-shell.nix"
  ];

  options.modules.nixos-desktop.dms = {
    enable = lib.mkEnableOption "Enable DankMaterialShell";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dgop
      cava
      matugen
      kdePackages.kimageformats
    ];

    programs.dms-shell = {
      enable = true;
      package = dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableVPN = true;
      enableDynamicTheming = true;
      enableClipboardPaste = true;
      enableSystemMonitoring = true;
    };
  };
}
