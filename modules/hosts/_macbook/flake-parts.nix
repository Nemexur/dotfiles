{inputs, ...}: let
  system = "aarch64-darwin";
in {
  flake.darwinConfigurations = inputs.self.lib.mkDarwin {
    inherit system;
    name = "macbook"; # FIXME
  };
  flake.homeConfigurations = inputs.self.lib.mkHomeManager {
    inherit system;
    name = "a.n.milogradskiy";
  };
}
