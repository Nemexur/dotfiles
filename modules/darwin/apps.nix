{
  # homebrew need to be installed manually
  homebrew = {
    enable = false;

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

    taps = [
      "hashicorp/tap"
      "nikitabobko/tap" # aerospace - an i3-like tiling window manager for macOS
    ];

    brews = [
      "m-cli"

      "pinentry-touchid"
    ];

    casks = [
      # browsers
      "brave-browser"
      "zen"

      # development tools
      "visual-studio-code"
      "dbeaver-community"

      # note taking
      "obsidian"
      "raindropio"
      "mactex"
      "sioyek"

      # tiling window manager
      "aerospace"

      # video player
      "iina"

      # tools
      "alfred"
      "numi"
      "stats"
      "rectangle"
      "karabiner-elements"
      "logitech-options"
      "ukelele"
      "wine-stable"

      # others
      "vagrant-manager"
      "macfuse"
      "imazing"
      "mouse-fix"
    ];
  };
}
