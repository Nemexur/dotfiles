{
  flake.modules.nixos.gnome = {
    lib,
    pkgs,
    ...
  }: {
    environment = {
      systemPackages = with pkgs; [
        gnomeExtensions.just-perfection
        gnomeExtensions.color-picker
        gnomeExtensions.user-themes
      ];

      gnome.excludePackages = with pkgs; [
        atomix
        cheese
        epiphany
        evince
        geary
        gedit
        gnome-characters
        gnome-connections
        gnome-contacts
        gnome-font-viewer
        gnome-initial-setup
        gnome-maps
        gnome-music
        gnome-photos
        gnome-shell-extensions
        gnome-terminal
        gnome-tour
        hitori
        iagno
        nautilus
        snapshot
        tali
        totem
        yelp
      ];
    };

    services = {
      desktopManager.gnome.enable = lib.mkDefault true;
      displayManager.gdm = {
        enable = lib.mkDefault true;
      };
    };
  };
}
