{inputs, ...}: {
  flake-file.inputs = {
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  flake.modules.nixos.gaming = {
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.nix-gaming.nixosModules.platformOptimizations
    ];
  };
}
