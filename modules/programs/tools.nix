let
  fzf = {
    programs.fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };
  };
  nh = {config, ...}: {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3";
      flake = "${config.home.homeDirectory}/.dotfiles";
    };
  };
  starship = {
    programs.starship = {
      enable = true;
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
  };
  tealdeer = {
    programs.tealdeer = {
      enable = true;
      settings.update.auto_update = true;
    };
  };
  zoxide = {
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };
in
  {
    flake.modules.homeManager = {
      inherit fzf nh starship tealdeer zoxide;
    };
    flake.modules.homeManager.tools = {pkgs, ...}: {
      imports = [
        fzf
        nh
        starship
        tealdeer
        zoxide
      ];

      home = {
        packages = with pkgs.unstable; [
          # Tools
          eza
          bat
          gopass
          manix
          trash-cli
          fd
          yazi
          (lib.hiPrio parallel)
          (ripgrep.override {withPCRE2 = true;})

          # K8s
          kubectl
          kubectx

          # Compression
          zip
          xz
          zstd
          unzipNLS
          p7zip

          # File Transfers
          rsync
          croc

          # Misc
          ani-cli

          # GUI Apps
          obsidian
          dbeaver-bin
          telegram-desktop
          sioyek
          winbox4
        ];
      };
    };
  }
