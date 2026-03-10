{pkgs, ...}: {
  # gpg agent with pinentry
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage =
      if pkgs.stdenv.isDarwin
      then pkgs.pinentry_mac
      else pkgs.pinentry-qt;
    enableSSHSupport = false;
    settings.default-cache-ttl = 4 * 60 * 60; # 4 hours
  };
}
