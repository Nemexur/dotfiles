{inputs, ...}: {
  flake-file.inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.agenix = {pkgs, ...}: {
    environment.systemPackages = [inputs.agenix-rekey.packages.${pkgs.stdenv.hostPlatform.system}.default];

    imports = [
      inputs.agenix.nixosModules.default
      inputs.agenix-rekey.nixosModules.default
    ];
  };
  flake.modules.darwin.agenix = {pkgs, ...}: {
    environment.systemPackages = [inputs.agenix-rekey.packages.${pkgs.stdenv.hostPlatform.system}.default];

    imports = [
      inputs.agenix.darwinModules.default
      inputs.agenix-rekey.darwinModules.default
    ];
  };
  flake.modules.homeManager.agenix = {
    imports = [
      inputs.agenix.homeManagerModules.default
      inputs.agenix-rekey.homeManagerModules.default
    ];
  };
}
