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
  userfullname = myVars.userfullname;

  specialArgs =
    (genSpecialArgs system)
    // {
      inherit username;
      inherit userfullname;
    };

  nixos-modules = map buildPath ["modules/nixos/desktop" "hosts/nixos-${name}"];

  home-modules = map buildPath ["home/nixos"];
in {
  nixosConfigurations.${name} = nixpkgs.lib.nixosSystem {
    inherit system specialArgs;
    modules =
      [inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen5]
      ++ nixos-modules
      ++ [
        {
          modules.host.power-optim.service = "tuned";
          modules.nixos-base.ssh.enable = false;
          modules.nixos-desktop.gaming.enable = true;
          modules.nixos-desktop.kanata.enable = true;
          modules.nixos-desktop.fingerprint.enable = true;
          modules.nixos-desktop.trackpoint.enable = true;
          modules.nixos-desktop.niri.enable = true;
          modules.nixos-desktop.dms.enable = false;
        }
      ]
      ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "home-manager.backup";

          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users."${username}" = {
            imports = home-modules;
            home-modules.gaming.enable = true;
            home-modules.niri.enable = true;
            home-modules.shell.noctalia.enable = true;
            home-modules.browser.zen = {
              enable = true;
              enableVaapi = true;
              useWayland = true;
            };
          };
        }
      ];
  };
}
