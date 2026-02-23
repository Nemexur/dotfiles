{
  inputs,
  lib,
  myVars,
  system,
  genSpecialArgs,
}: let
  inherit (inputs) nixpkgs home-manager;

  buildPath = lib.path.append myVars.projectRoot;

  name = "luffy";
  username = "nemexur";

  specialArgs =
    (genSpecialArgs system)
    // {
      inherit username;
    };

  nixos-modules = map buildPath ["modules/nixos/desktop" "hosts/nixos-${name}"];

  home-modules = map buildPath ["home/nixos"];
in {
  nixosConfigurations.${name} = nixpkgs.lib.nixosSystem {
    inherit system specialArgs;
    modules =
      nixos-modules
      ++ [
        {
          modules.nixos-base.ssh.enable = false;
          modules.nixos-base.power.enable = true;
          modules.nixos-desktop.gaming.enable = true;
          modules.nixos-desktop.kanata.enable = true;
        }
      ]
      ++ [
        home-manager.nixosModules.home-manager
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
