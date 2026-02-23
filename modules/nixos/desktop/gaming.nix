{
  lib,
  pkgs,
  nix-gaming,
  config,
  ...
}: let
  cfg = config.modules.nixos-desktop.gaming;
in {
  imports = [
    nix-gaming.nixosModules.pipewireLowLatency
    nix-gaming.nixosModules.platformOptimizations
  ];

  options.modules.nixos-desktop = {
    gaming = {
      enable = lib.mkEnableOption "Gaming Optimizations";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    # see https://github.com/fufexan/nix-gaming/#pipewire-low-latency
    services.pipewire.lowLatency.enable = true;
    programs.steam.platformOptimizations.enable = true;

    # Optimise Linux system performance on demand
    # https://github.com/FeralInteractive/GameMode
    # https://wiki.archlinux.org/title/Gamemode
    programs.gamemode.enable = true;
  };
}
