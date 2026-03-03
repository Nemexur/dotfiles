{
  lib,
  config,
  pkgs,
  myVars,
  username ? myVars.username,
  ...
}: let
  cfg = config.modules.nixos-desktop.niri;
in {
  options.modules.nixos-desktop.niri = {
    enable = lib.mkEnableOption "Enable Niri";
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    services = {
      xserver.enable = lib.mkForce false; # disable xorg server
      # https://wiki.archlinux.org/title/Greetd
      greetd = {
        enable = true;
        settings = {
          default_session = {
            user = username;
            command = "niri-session";
          };
        };
      };
    };

    xdg.portal = {
      enable = true;

      config = {
        common = {
          # Use xdg-desktop-portal-gtk for every portal interface...
          default = [
            "gtk"
            "gnome"
          ];
        };
      };
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk # for provides file picker / OpenURI
        xdg-desktop-portal-gnome # for screensharing
      ];
    };
  };
}
