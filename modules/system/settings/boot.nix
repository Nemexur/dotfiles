{
  flake.modules.nixos.boot = {
    lib,
    pkgs,
    ...
  }: {
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = lib.mkDefault 10;
      consoleMode = lib.mkDefault "max";
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = lib.mkForce 10;
  };
}
