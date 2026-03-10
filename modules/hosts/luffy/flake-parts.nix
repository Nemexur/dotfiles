{inputs, ...}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations = inputs.self.lib.mkNixos {
    inherit system;
    name = "luffy";
  };
  flake.homeConfigurations = inputs.self.lib.mkHomeManager {
    inherit system;
    name = "nemexur-luffy";
  };
}
