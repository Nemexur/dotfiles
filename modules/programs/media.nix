{
  flake.modules.homeManager.media = {pkgs, ...}: {
    home.packages = with pkgs.unstable;
      if pkgs.stdenv.isLinux
      then [
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
      ]
      else [iina];

    programs.mpv = {
      enable = pkgs.stdenv.isLinux;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.unstable.mpvScripts.mpris];
    };
    services.playerctld.enable = pkgs.stdenv.isLinux;
  };
}
