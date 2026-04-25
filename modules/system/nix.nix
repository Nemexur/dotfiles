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
    # enable flakes globally
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.extra-experimental-features = ["pipe-operators"];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix.package = pkgs.nix;

    nix.settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
      builders-use-substitutes = true;
    };

    nix.settings.trusted-users =
      ["root"]
      ++ (
        if pkgs.stdenv.isDarwin
        then ["@admin"]
        else ["@wheel"]
      );
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
