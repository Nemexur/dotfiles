{
  flake.modules.homeManager.luffy-secrets = {
    lib,
    config,
    ...
  }: {
    programs.zsh.initContent = lib.mkOrder 2000 ''
      if [ -f ${config.age.secrets.home-envs.path} ]; then
        source ${config.age.secrets.home-envs.path}
      fi
    '';
  };
}
