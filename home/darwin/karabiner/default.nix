{
  config,
  pkgs,
  ...
}: let
  configPath = "${config.home.homeDirectory}/.dotfiles/home/darwin/karabiner";
in {
  xdg.configFile."karabiner".source = config.lib.file.mkOutOfStoreSymlink configPath;

  home.packages = with pkgs; [karabiner-elements];
}
