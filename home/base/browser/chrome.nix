{pkgs, ...}: {
  programs.google-chrome = {
    enable = true;
    package =
      if pkgs.stdenv.isAarch64
      then pkgs.chromium
      else pkgs.google-chrome;
  };
}
