{lib, pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      gnomeExtensions.just-perfection
      gnomeExtensions.color-picker
      gnomeExtensions.user-themes
    ];

    gnome.excludePackages = with pkgs; [
      # gnome-text-editor
      # gnome-console
      gnome-photos
      gnome-tour
      gnome-connections
      snapshot
      gedit
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      totem # video player
      yelp # Help view
      gnome-font-viewer
      gnome-shell-extensions
      gnome-maps
      gnome-music
      gnome-characters
      gnome-contacts
      gnome-initial-setup
    ];
  };

  programs.kdeconnect.enable = true;

  services = {
    desktopManager.gnome.enable = lib.mkDefault true;
    displayManager.gdm = {
      enable = lib.mkDefault true;
      wayland = true;
    };
  };
}
