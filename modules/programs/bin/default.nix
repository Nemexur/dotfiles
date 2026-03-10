{
  flake.modules.homeManager.localBin = {lib, ...}: {
    home = {
      sessionPath = ["$HOME/.local/bin"];
      file = let
        binScripts = scriptsDir:
          builtins.listToAttrs
          (map
            (name: {
              name = ".local/bin/${name}";
              value = {
                source = lib.path.append scriptsDir "${name}";
                executable = true;
              };
            })
            (builtins.attrNames (builtins.readDir scriptsDir)));
      in
        binScripts ./_scripts;
    };
  };
}
