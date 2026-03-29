{
  flake.modules.homeManager.work-envs-secret = {
    lib,
    config,
    ...
  }: let
    secretsDir = ../../secrets;
  in {
    age.secrets.work-envs.file = lib.path.append secretsDir "work-envs.age";

    programs.zsh.initContent = lib.mkOrder 1100 ''
      if [ -f ${config.age.secrets.work-envs.path} ]; then
        source ${config.age.secrets.work-envs.path}
      fi
    '';
  };
}
