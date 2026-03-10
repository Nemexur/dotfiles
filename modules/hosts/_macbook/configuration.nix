{inputs, ...}: {
  flake.modules.nixos.macbook = {
    imports = with inputs.self.modules.darwin; [
      home-manager
    ];
  };
}
