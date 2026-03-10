# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    dms = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:AvengeMedia/DankMaterialShell/stable";
    };
    dms-plugin-registry = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:AvengeMedia/dms-plugin-registry";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs-stable";
      url = "github:nix-community/home-manager/release-25.11";
    };
    import-tree.url = "github:vic/import-tree";
    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs-darwin";
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
    };
    nix-gaming = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:fufexan/nix-gaming";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    noctalia = {
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        noctalia-qs.follows = "noctalia-qs";
      };
      url = "github:noctalia-dev/noctalia-shell";
    };
    noctalia-qs = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:noctalia-dev/noctalia-qs";
    };
    zen-browser = {
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs-unstable";
      };
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

}
