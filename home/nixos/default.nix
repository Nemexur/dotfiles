{
  pkgs-unstable,
  myVars,
  username ? myVars.username,
  ...
}: {
  imports = [
    ../base
    ./niri
    ./noctalia
    ./gaming.nix
    ./hypridle.nix
    ./media.nix
    ./mime.nix
    ./rofi.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

    packages = with pkgs-unstable; [
      swaybg
      networkmanagerapplet
      wineWow64Packages.waylandFull
      kdePackages.qtwayland
    ];
    sessionVariables = {
      "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
      "ELECTRON_OZONE_PLATFORM_HINT" = "auto"; # enable native Wayland support for most Electron apps
    };
  };
}
