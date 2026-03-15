{inputs, ...}: {
  flake.modules.darwin.zoro = {
    imports = with inputs.self.modules.darwin;
      [
        # Minimal
        nix
        agenix
        home-manager
        systemPackages

        # System Settings
        docker
        fonts
        locale
        systemSettings
        russianTypeWriterLayout

        # Services
        karabiner
        aerospace

        # Programs
        brew
        manpage
      ]
      ++ (with inputs.self.modules.generic; [
        systemConstants
        pkgs-by-name
        secrets
      ])
      ++ [
        {
          brewSettings = {
            enable = true;
            casks = ["karabiner-elements"];
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
          };
        }
      ];
  };
}
