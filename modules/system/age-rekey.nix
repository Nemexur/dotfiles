let
  ageCfg = localStorageDir: {lib, ...}: {
    storageMode = lib.mkDefault "local";
    masterIdentities = lib.mkDefault [../../secrets/yubikey-identity.pub];
    localStorageDir = lib.mkDefault localStorageDir;
  };
in {
  flake.modules.nixos.age-rekey = {config, ...} @ args: {
    age.rekey = ageCfg (../../secrets/rekeyed/${config.networking.hostName}) args;
  };
  flake.modules.darwin.age-rekey = {config, ...} @ args: {
    age.rekey = ageCfg (../../secrets/rekeyed/${config.networking.hostName}) args;
  };
  flake.modules.homeManager.age-rekey = {config, ...} @ args: {
    age.rekey = ageCfg (../../secrets/rekeyed/home-${config.networking.hostName}) args;
  };
}
