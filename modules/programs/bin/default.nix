{
  flake.modules.homeManager.localBin = {lib, ...}: {
    home = {
      sessionPath = ["$HOME/.local/bin"];
      file = let
        binScripts = scriptsDir:
          scriptsDir
          |> builtins.readDir
          |> builtins.attrNames
          |> map (name: {
            name = ".local/bin/${name}";
            value = {
              source = lib.path.append scriptsDir "${name}";
              executable = true;
            };
          })
          |> builtins.listToAttrs;
      in
        binScripts ./_scripts;
    };
  };
}
