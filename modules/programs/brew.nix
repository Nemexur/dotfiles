{
  flake.modules.darwin.brew = {
    lib,
    config,
    ...
  }: {
    options.brewSettings = {
      enable = lib.mkEnableOption "Whether to enable HomeBrew or not";
      masApps = lib.mkOption {
        type = lib.types.attrs;
        default = {};
      };
      casks = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
    };

    config = let
      cfg = config.brewSettings;
    in {
      homebrew = {
        enable = cfg.enable;

        onActivation = {
          autoUpdate = true; # fetch the newest stable branch of Homebrew's git repo
          upgrade = true; # upgrade outdated casks, formulae, and App Store apps
          cleanup = "zap";
          extraFlags = ["--force-cleanup"];
        };

        # Applications to install from Mac App Store using mas.
        # For details, see https://github.com/mas-cli/mas
        masApps = cfg.masApps;
        casks = cfg.casks;
      };
    };
  };
}
