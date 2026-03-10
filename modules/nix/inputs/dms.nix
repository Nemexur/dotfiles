{inputs, ...}: {
  flake-file.inputs = {
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  flake.modules.nixos.dms = {
    imports = [
      inputs.dms-plugin-registry.modules.default
      "${inputs.pkgs-unstable.path}/nixos/modules/programs/wayland/dms-shell.nix"
    ];
  };
}
