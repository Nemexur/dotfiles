{inputs, ...}: {
  flake-file.inputs = {
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  flake.modules.nixos.gaming = {
    imports = [
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.nix-gaming.nixosModules.platformOptimizations
    ];
  };
}
