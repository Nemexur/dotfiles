{
  programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      # Get editor completions based on the config schema
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      battery.disabled = true;
      git_status.disabled = true;
      python.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes = {
        symbol = "⛵";
        disabled = false;
      };
      os.disabled = false;
    };
  };
}
