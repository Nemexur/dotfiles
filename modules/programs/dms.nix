{
  flake.modules.nixos.dms = {
    pkgs,
    inputs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      dgop
      cava
      matugen
      kdePackages.kimageformats
    ];

    programs.dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

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
