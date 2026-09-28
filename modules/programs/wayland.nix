{
  flake.modules.nixos.wayland = {pkgs, ...}: {
    services.dbus.enable = true;

    environment.systemPackages = with pkgs; [
      libnotify
      wineWow64Packages.waylandFull
      kdePackages.qtwayland
    ];
  };
}
