{
  lib,
  pkgs,
  ...
}: {
  xdg.terminal-exec = {
    enable = true;
    package = pkgs.xdg-terminal-exec;
    settings = let
      terminalDesktop = [
        "com.mitchellh.ghostty.desktop"
        "kitty.desktop"
      ];
    in {
      default = terminalDesktop;
      niri = terminalDesktop;
    };
  };

  xdg = {
    autostart.enable = lib.mkDefault true;
    menus.enable = lib.mkDefault true;
    mime.enable = lib.mkDefault true;
    icons.enable = lib.mkDefault true;
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
}
