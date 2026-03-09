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
            command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
          };
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

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
}
