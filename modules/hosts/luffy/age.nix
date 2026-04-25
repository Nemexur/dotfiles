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
      hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDad9sqVYn5NAwkAjSfpGmp6n9wie1HaqsshE5yUZIV8";
      localStorageDir = ../../../secrets/rekeyed/home-luffy;
    };
  };
}
