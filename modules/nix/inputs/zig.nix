{inputs, ...}: {
  flake-file.inputs = {
    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
}
