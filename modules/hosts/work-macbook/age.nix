{
  flake.modules.darwin.work-macbook = {
    age.rekey = {
      hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENGD3l2lJ369yQ5GGQ5pnHnBq8RulzQlbFGAJMl1zN0";
      localStorageDir = ../../../secrets/rekeyed/work-macbook;
    };
  };

  flake.modules.homeManager.work-macbook-secret = {
    lib,
    config,
    ...
  }: {
    age.identityPaths = ["${config.home.homeDirectory}/.ssh/agenix"];
    age.rekey = {
      hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDad9sqVYn5NAwkAjSfpGmp6n9wie1HaqsshE5yUZIV8";
      localStorageDir = ../../../secrets/rekeyed/home-work-macbook;
    };

    age.secrets.work-envs.rekeyFile = ./work-envs.age;
    age.secrets.opencode-config.rekeyFile = ./opencode-config.age;
    programs.zsh.initContent = lib.mkOrder 1100 ''
      if [ -f ${config.age.secrets.work-envs.path} ]; then
        source ${config.age.secrets.work-envs.path}
      fi
      if [ -f ${config.age.secrets.opencode-config.path} ]; then
        export OPENCODE_CONFIG="${config.age.secrets.opencode-config.path}"
      fi
    '';
  };
}
