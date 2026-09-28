{inputs, ...}: let
  system = "x86_64-linux";
in {
  flake.configurations.nixos = inputs.self.lib.mkNixos {
    inherit system;
    name = "luffy";
  };
}
