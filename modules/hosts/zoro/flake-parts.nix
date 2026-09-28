{inputs, ...}: let
  system = "aarch64-darwin";
in {
  flake.configurations.darwin = inputs.self.lib.mkDarwin {
    inherit system;
    name = "zoro";
  };
}
