{
  inputs,
  lib,
  ...
}: let
  stateVersion = "25.11";
in {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {
    mkNixos = {
      system,
      name,
      nameAsHostName ? true,
    }: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit name;
        };
        modules =
          [
            inputs.self.modules.nixos.${name}
            {nixpkgs.hostPlatform = lib.mkDefault system;}
            {system.stateVersion = lib.mkDefault stateVersion;}
          ]
          ++ lib.optionals nameAsHostName [
            {networking.hostName = lib.mkDefault name;}
          ];
      };
    };

    mkDarwin = {
      system,
      name,
      nameAsHostName ? true,
    }: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit name;
        };
        modules =
          [
            inputs.self.modules.darwin.${name}
            {nixpkgs.hostPlatform = lib.mkDefault system;}
            {networking.hostName = lib.mkDefault name;}
          ]
          ++ lib.optionals nameAsHostName [
            {networking.hostName = lib.mkDefault name;}
          ];
      };
    };

    mkHomeManager = {
      system,
      name,
    }: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          inputs.self.modules.homeManager.${name}
          {nixpkgs.config.allowUnfree = true;}
        ];
      };
    };
  };
}
