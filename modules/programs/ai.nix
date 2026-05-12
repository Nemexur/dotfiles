{
  flake.modules.homeManager.ai = {
    lib,
    pkgs,
    config,
    ...
  }: {
    options.homeAiSettings = {
      opencodeProviders = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "Configuration of Custom Providers in OpenCode";
      };
    };

    config = let
      cfg = config.homeAiSettings;
    in {
      home.packages = [pkgs.local.opendataloader-pdf];

      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        enableMcpIntegration = true;
        settings = lib.mkMerge [
          {
            theme = "system";
            permission = {
              read = {
                "*" = "allow";
                "*.env" = "deny";
                "*.env.*" = "deny";
                "*.env.example" = "allow";
              };
            };
          }

          (lib.mkIf (cfg.opencodeProviders != {}) {
            provider = cfg.opencodeProviders;
          })
        ];
      };
    };
  };
}
