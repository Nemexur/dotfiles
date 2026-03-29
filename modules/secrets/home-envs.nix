{
  flake.modules.homeManager.home-envs-secret = {
    lib,
    config,
    ...
  }: let
    secretsDir = ../../secrets;
  in {
    age.secrets.home-envs.file = lib.path.append secretsDir "home-envs.age";

    programs.zsh.initContent = lib.mkOrder 1100 ''
      if [ -f ${config.age.secrets.home-envs.path} ]; then
        source ${config.age.secrets.home-envs.path}
      fi
    '';
  };
}
