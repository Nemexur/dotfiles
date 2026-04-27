{
  flake.modules.nixos.gnupg = {
    services.pcscd.enable = true;
  };

  flake.modules.homeManager.gnupg = {pkgs, ...}: {
    home.packages = with pkgs.unstable; [age-plugin-yubikey];

    programs.gpg = {
      enable = true;
      scdaemonSettings.disable-ccid = true;
      publicKeys = [
        {
          source = ./yubikey.asc;
          trust = "ultimate";
        }
      ];
      settings = {
        personal-cipher-preferences = "AES256 AES192 AES";
        personal-digest-preferences = "SHA512 SHA384 SHA256";
        personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        cert-digest-algo = "SHA512";
        s2k-digest-algo = "SHA512";
        s2k-cipher-algo = "AES256";
        display-charset = "utf-8";
        no-comments = true;
        no-emit-version = true;
        keyid-format = "0xlong";
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";
        with-fingerprint = true;
        require-cross-certification = true;
        require-secmem = true;
        no-symkey-cache = true;
        armor = true;
        use-agent = true;
      };
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 60; # 1 min
      maxCacheTtl = 120; # 2 min
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
