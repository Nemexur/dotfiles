{
  flake.modules.darwin.karabiner = {pkgs, ...}: {
    # https://github.com/nix-darwin/nix-darwin/issues/1041
    services.karabiner-elements.enable = false;
  };

  flake.modules.homeManager.karabiner = {pkgs, config, ...}: {
    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/modules/services/karabiner/_conf";
    in {
      "karabiner".source = mkSymlink configPath;
    };
  };
}
