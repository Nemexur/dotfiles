{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      platformOptimizations.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      lowLatency = {
        # enable this module
        enable = true;
        # defaults (no need to be set unless modified)
        quantum = 64;
        rate = 48000;
      };
    };

    # make pipewire realtime-capable
    security.rtkit.enable = true;

    # Optimise Linux system performance on demand
    # https://github.com/FeralInteractive/GameMode
    # https://wiki.archlinux.org/title/Gamemode
    programs.gamemode.enable = true;
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      # https://github.com/flightlessmango/MangoHud
      # a simple overlay program for monitoring FPS, temperature, CPU and GPU load, and more.
      mangohud

      # GUI for installing custom Proton versions like GE_Proton
      # proton - a Wine distribution aimed at gaming
      protonplus
      # Script to install various redistributable runtime libraries in Wine.
      winetricks
      # https://github.com/Open-Wine-Components/umu-launcher
      # a unified launcher for Windows games on Linux
      umu-launcher

      # Sed-like editor for binary files
      # required by some games to fix problems
      bbe
    ];
  };
}
