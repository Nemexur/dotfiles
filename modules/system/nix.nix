{inputs, ...}: let
  genericPkg = {pkgs, ...}: {
    nixpkgs.overlays = [
      (final: _prev: {
        stable = import inputs.nixpkgs-stable {
          inherit (final) config;
          system = pkgs.stdenv.hostPlatform.system;
        };
        unstable = import inputs.nixpkgs-unstable {
          inherit (final) config;
          system = pkgs.stdenv.hostPlatform.system;
        };
      })
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix.package = pkgs.nix;

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      extra-experimental-features = ["pipe-operators"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://noctalia.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
      builders-use-substitutes = true;
      trusted-users =
        ["root"]
        ++ (
          if pkgs.stdenv.isDarwin
          then ["@admin"]
          else ["@wheel"]
        );
    };
  };
in {
  flake.modules.nixos.nix = genericPkg;
  flake.modules.darwin.nix = {
    imports = [genericPkg];

    nixpkgs.overlays = [
      inputs.brew-nix.overlays.default
    ];
  };
}
