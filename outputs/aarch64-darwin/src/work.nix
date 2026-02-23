{
  inputs,
  lib,
  myVars,
  system,
  genSpecialArgs,
}: let
  inherit (inputs) nix-darwin home-manager;

  buildPath = lib.path.append myVars.projectRoot;

  name = "work";
  username = "a.n.milogradskiy";

  specialArgs =
    (genSpecialArgs system)
    // {
      inherit username;
    };

  darwin-modules = map buildPath ["modules/darwin" "hosts/darwin-${name}"];

  home-modules = map buildPath ["home/darwin"];
in {
  darwinConfigurations.${name} = nix-darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules =
      darwin-modules
      ++ [
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "home-manager.backup";

          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users."${username}".imports = home-modules;
        }
      ];
  };
}
