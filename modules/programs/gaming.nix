{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
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
