{
  flake.modules.nixos.niri = {
    lib,
    pkgs,
    ...
  }: {
    programs.niri.enable = true;

    xdg.portal = {
      enable = true;
      config.common.default = ["gtk" "kde"];
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        kdePackages.xdg-desktop-portal-kde
      ];
    };
  };

  flake.modules.homeManager.niri = {
    config,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      xwayland-satellite
      wtype
      swaylock
    ];

    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/modules/programs/niri/_conf";
    in {
      "niri".source = mkSymlink configPath;
    };
  };
}
