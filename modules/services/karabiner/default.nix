{
  flake.modules.darwin.karabiner = {
    # https://github.com/nix-darwin/nix-darwin/issues/1041
    # services.karabiner-elements.enable = true;
  };

  flake.modules.homeManager.karabiner = {config, ...}: {
    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/modules/services/karabiner/_conf";
    in {
      "karabiner".source = mkSymlink configPath;
    };
  };
}
