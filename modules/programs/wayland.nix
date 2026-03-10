{
  flake.modules.homeManager.wayland = {pkgs, ...}: {
    home.packages = with pkgs; [
      wineWow64Packages.waylandFull
      kdePackages.qtwayland
    ];
  };
}
