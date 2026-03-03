{
  pkgs,
  myVars,
  username ? myVars.username,
  ...
}: {
  imports = [../base ./niri ./noctalia ./gaming.nix ./rofi.nix];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";

    packages = with pkgs; [
      wineWow64Packages.waylandFull
      kdePackages.qtwayland
    ];
  };
}
