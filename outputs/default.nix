{nixpkgs, ...} @ inputs: let
  inherit (nixpkgs) lib;

  myVars = import ../vars;

  genSpecialArgs = system:
    inputs
    // {
      inherit myVars;

      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  args = {
    inherit
      inputs
      lib
      myVars
      genSpecialArgs
      ;
  };

  nixosSystems = {
    x86_64-linux = import ./x86_64-linux (args // {system = "x86_64-linux";});
  };
  darwinSystems = {
    aarch64-darwin = import ./aarch64-darwin (args // {system = "aarch64-darwin";});
  };
  nixosSystemValues = builtins.attrValues nixosSystems;
  darwinSystemValues = builtins.attrValues darwinSystems;
in {
  # NixOS Hosts
  nixosConfigurations = lib.attrsets.mergeAttrsList (
    map (s: s.nixosConfigurations or {}) nixosSystemValues
  );
  # MacOS Hosts
  darwinConfigurations = lib.attrsets.mergeAttrsList (
    map (s: s.darwinConfigurations or {}) darwinSystemValues
  );
}
