{
  flake.modules.homeManager.npm = {
    lib,
    pkgs,
    config,
    ...
  }: let
    xdgConfigHome = lib.removePrefix config.home.homeDirectory config.xdg.configHome;
    configFile =
      if config.home.preferXdgDirectories
      then "${xdgConfigHome}/npm/npmrc"
      else ".npmrc";
    toNpmrc = let
      mkLine = lib.generators.mkKeyValueDefault {} "=";
      mkLines = k: v:
        if lib.isList v
        then map (x: mkLine "${k}[]" x) v
        else [(mkLine k v)];
    in
      attrs: lib.mapAttrsToList mkLines attrs |> lib.concatLists |> lib.concatLines;
  in {
    home = {
      packages = with pkgs.unstable; [nodejs_25];
      file.${configFile}.text = toNpmrc {
        prefix = "\${HOME}/.npm";
      };
      sessionVariables = {
        NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/${configFile}";
      };
    };
  };
}
