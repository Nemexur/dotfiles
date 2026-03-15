{inputs, ...}: let
  system = "aarch64-darwin";
in {
  flake.configurations.darwin = inputs.self.lib.mkDarwin {
    inherit system;
    name = "work-macbook";
    nameAsHostName = false;
  };
  flake.configurations.homeManager = inputs.self.lib.mkHomeManager {
    inherit system;
    name = "a.n.milogradskiy";
  };
}
