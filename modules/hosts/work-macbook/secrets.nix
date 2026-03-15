{
  flake.modules.homeManager.work-macbook-secrets = {
    lib,
    config,
    ...
  }: {
    programs.zsh.initContent = lib.mkOrder 2000 ''
      if [ -f ${config.age.secrets.home-envs.path} ]; then
        source ${config.age.secrets.home-envs.path}
      fi
      if [ -f ${config.age.secrets.work-envs.path} ]; then
        source ${config.age.secrets.work-envs.path}
      fi
    '';
  };
}
