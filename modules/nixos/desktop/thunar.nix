{pkgs-unstable, ...}: {
  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };
  programs = {
    dconf.enable = true;
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs-unstable; [
        thunar-shares-plugin
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
