{pkgs, ...}: {
  environment.systemPackages = with pkgs; [man-pages man-pages-posix];

  documentation = {
    man.enable = true;
    doc.enable = true;
    info.enable = true;
    dev.enable = true;
    nixos.includeAllModules = true;
  };
}
