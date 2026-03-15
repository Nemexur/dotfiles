{inputs, ...}: let
  system = "aarch64-darwin";
in {
  flake.configurations.darwin = inputs.self.lib.mkDarwin {
    inherit system;
    name = "zoro";
  };
  flake.configurations.homeManager = inputs.self.lib.mkHomeManager {
    inherit system;
    name = "nemexur";
  };
}
