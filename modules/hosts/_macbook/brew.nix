{
  flake.modules.nixos.macbook = {
    # homebrew need to be installed manually
    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = true; # fetch the newest stable branch of Homebrew's git repo
        upgrade = true; # upgrade outdated casks, formulae, and App Store apps
        cleanup = "zap";
      };

      # Applications to install from Mac App Store using mas.
      # For details, see https://github.com/mas-cli/mas
      masApps = {
        Dropover = 1355679052;
        "Dropzone 4" = 1485052491;
        Endel = 1346247457;
        Exporter = 1099120373;
        Infuse = 1136220934;
        "MarginNote 4" = 1531657269;
        Notability = 360593530;
        Twingate = 1501592214;
        UpNote = 1398373917;
        WireGuard = 1451685025;
      };

      brews = ["pinentry-touchid"];

      casks = [
        # note taking
        "raindropio"

        # tools
        "alfred"
        "logitech-options"
        "ukelele"
        "wine-stable"

        # others
        "macfuse"
        "imazing"
        "mouse-fix"
      ];
    };
  };
}
