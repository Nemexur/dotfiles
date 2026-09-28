{inputs, ...}: {
  flake.modules.darwin.work-macbook = let
    workCert = "/etc/ssl/certs/work-bundle.crt";
  in {
    nix.settings.ssl-cert-file = workCert;
    security.pki.certificateFiles = [workCert];
    environment.variables.NIX_SSL_CERT_FILE = workCert;

    imports = with inputs.self.modules.darwin;
      [
        # Minimal
        nix
        agenix
        home-manager
        systemPackages

        # System Settings
        age-rekey
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
        yubikey
      ]
      ++ (with inputs.self.modules.generic; [
        systemConstants
        pkgs-by-name
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
              Twingate = 1501592214;
              UpNote = 1398373917;
              WireGuard = 1451685025;
            };
          };
        }
      ];
  };
}
