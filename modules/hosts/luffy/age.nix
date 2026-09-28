{
  flake.modules.nixos.luffy = {
    age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB1sDaqbpFRDEKPa3CtsAacX3mS1KetWNcFcbVWx22RY";
  };

  flake.modules.homeManager.luffy-secret = {
    lib,
    config,
    ...
  }: {
    age.identityPaths = ["${config.home.homeDirectory}/.ssh/agenix"];
    age.rekey = {
      hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/z0IJo6bPu+y6UwuqcIaQLfteC58rilVeSQKBwgWDp";
      localStorageDir = ../../../secrets/rekeyed/home-luffy;
    };
  };
}
