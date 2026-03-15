{
  flake.modules.homeManager.gnupg = {pkgs, ...}: {
    home.packages = [pkgs.gnupg];

    services.gpg-agent = {
      enable = true;
      enableSshSupport = false;
      defaultCacheTtl = 60 * 60; # 1 hour
      pinentry = {
        package =
          if pkgs.stdenv.isDarwin
          then pkgs.local.pinentry-touchid
          else pkgs.pinentry-qt;
        program =
          if pkgs.stdenv.isDarwin
          then "pinentry-touchid"
          else "pinentry-qt";
      };
    };
  };
}
