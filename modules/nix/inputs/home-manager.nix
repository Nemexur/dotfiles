{inputs, ...}: let
  home-manager-config.home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager.backup";
  };
in {
  flake-file.inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      home-manager-config
    ];
  };
  flake.modules.darwin.home-manager = {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      home-manager-config
    ];
  };
}
