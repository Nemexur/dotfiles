{
  flake.modules.nixos.wayland = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      wineWow64Packages.waylandFull
      kdePackages.qtwayland
    ];
  };
}
