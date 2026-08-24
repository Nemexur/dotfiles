{inputs, ...}: {
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs-unstable";
        # https://github.com/0xc000022070/zen-browser-flake/issues/368
        # home-manager.follows = "home-manager";
      };
    };
  };

  flake.modules.homeManager.zen-browser = {
    imports = [
      inputs.zen-browser.homeModules.default
    ];
  };
}
