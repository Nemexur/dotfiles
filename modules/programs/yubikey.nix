let
  genericPkg = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # Tools for backing up keys
      paperkey
      pgpdump

      # Yubico's official tools
      yubikey-manager
      yubikey-personalization
      yubico-piv-tool
    ];
  };
in {
  flake.modules.nixos.yubikey = {pkgs, ...}: {
    imports = [genericPkg];

    environment.systemPackages = with pkgs; [
      # Tools for backing up keys
      parted
      cryptsetup

      # Yubico's official tools
      yubioath-flutter
    ];
  };
  flake.modules.darwin.yubikey = genericPkg;
}
