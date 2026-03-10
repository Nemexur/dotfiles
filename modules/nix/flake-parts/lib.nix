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
    }: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          {nixpkgs.hostPlatform = lib.mkDefault system;}
          {system.stateVersion = lib.mkDefault stateVersion;}
          {networking.hostName = lib.mkDefault name;}
        ];
      };
    };

    mkDarwin = {
      system,
      name,
    }: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          inputs.self.modules.darwin.${name}
          {nixpkgs.hostPlatform = lib.mkDefault system;}
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
