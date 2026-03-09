{pkgs-unstable, ...}: {
  home.packages = with pkgs-unstable; [
    # Image Viewer
    kdePackages.gwenview
    imv

    # Audio Control
    pavucontrol
    pulsemixer

    # Video/Audio Tools
    vlc
    vulkan-tools
    zoom-us
  ];

  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq"];
    scripts = [pkgs-unstable.mpvScripts.mpris];
  };
  services.playerctld.enable = true;

  # Thunar Theme
  gtk = {
    enable = true;
    theme = {
      name = "Rose Pine";
      package = pkgs-unstable.rose-pine-gtk-theme;
    };
    iconTheme = {
      name = "Rose Pine";
      package = pkgs-unstable.rose-pine-icon-theme;
    };
  };
}
