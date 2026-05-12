{
  flake.modules.nixos.v2raya = {
    services.v2raya.enable = true;
    networking.nftables.enable = true;
  };
}
