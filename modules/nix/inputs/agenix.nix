{inputs, ...}: {
  # TODO: Add agenix rekey
  flake-file.inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.agenix = {pkgs, ...}: {
    environment.systemPackages = [inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.agenix];

    imports = [
      inputs.agenix.nixosModules.default
    ];
  };
  flake.modules.darwin.agenix = {pkgs, ...}: {
    environment.systemPackages = [inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.agenix];

    imports = [
      inputs.agenix.darwinModules.default
    ];
  };
  flake.modules.homeManager.agenix = {
    imports = [
      inputs.agenix.homeManagerModules.default
    ];
  };
}
