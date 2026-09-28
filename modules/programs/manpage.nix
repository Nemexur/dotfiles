{
  flake.modules.nixos.manpage = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [man-pages man-pages-posix];

    documentation = {
      man.enable = true;
      doc.enable = true;
      info.enable = true;
      dev.enable = true;
    };
  };

  flake.modules.darwin.manpage = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [man-pages man-pages-posix];

    documentation = {
      man.enable = true;
      doc.enable = true;
      info.enable = true;
    };
  };
}
