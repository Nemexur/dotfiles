{
  flake.modules.homeManager.opencode = {
    lib,
    pkgs,
    config,
    ...
  }: {
    options.homeAiSettings.opencode = {
      providers = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "Configuration of Custom Providers in OpenCode";
      };
    };

    config = let
      cfg = config.homeAiSettings.opencode;
    in {
      programs.npm.enable = true;
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        enableMcpIntegration = true;
        tui.theme = "system";
        settings = lib.mkMerge [
          {
            plugin = ["opencode-claude-auth@latest" "opencode-openai-codex-auth@latest"];
            permission = {
              read = {
                "*" = "allow";
                "*.env" = "deny";
                "*.env.*" = "deny";
                "*.env.example" = "allow";
              };
            };
          }

          (lib.mkIf (cfg.providers != {}) {
            provider = cfg.providers;
          })
        ];
      };
    };
  };
}
