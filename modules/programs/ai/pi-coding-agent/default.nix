{
  flake.modules.homeManager.pi-coding-agent = {
    pkgs,
    config,
    ...
  }: {
    programs.npm.enable = true;

    home = {
      packages = [pkgs.local.pi-coding-agent];
      sessionVariables = {
        PI_CODING_AGENT_DIR = "${config.xdg.configHome}/pi-agent";
        PI_STATUSLINE_PRESET="classic";
      };
    };

    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/modules/programs/ai/pi-coding-agent/_conf";
    in {
      "pi-agent".source = mkSymlink configPath;
    };
  };
}
