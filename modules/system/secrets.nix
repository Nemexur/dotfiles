{
  flake.modules.generic.secrets = {lib, ...}: let
    secretsDir = ../../secrets;
  in {
    age.secrets.work-envs.file = lib.path.append secretsDir "work-envs.age";
    age.secrets.home-envs.file = lib.path.append secretsDir "home-envs.age";
  };
}
