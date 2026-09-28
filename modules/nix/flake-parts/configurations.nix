{
  lib,
  config,
  ...
}: {
  options.flake.configurations = {
    nixos = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    darwin = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    homeManager = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };

  config.flake = {
    nixosConfigurations = config.flake.configurations.nixos;
    darwinConfigurations = config.flake.configurations.darwin;
    homeConfigurations = config.flake.configurations.homeManager;
  };
}
