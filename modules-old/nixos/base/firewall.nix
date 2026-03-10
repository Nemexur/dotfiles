{lib, ...}: {
  networking.firewall.enable = lib.mkDefault false;
}
