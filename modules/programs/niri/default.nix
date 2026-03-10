{
  flake.modules.nixos.niri = {
    lib,
    pkgs,
    ...
  }: {
    programs.niri.enable = true;

    services = {
      xserver.enable = lib.mkForce false; # disable xorg server
      # https://wiki.archlinux.org/title/Greetd
      greetd = {
        enable = true;
        settings = {
          default_session = {
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
