{
  flake.modules.nixos.firmware = {
    services.fwupd.enable = true;
  };
}
