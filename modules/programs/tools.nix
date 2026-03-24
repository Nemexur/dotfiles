{inputs, ...}: let
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
        kubernetes.disabled = true;
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
in {
  flake.modules.homeManager = {
    inherit fzf nh starship tealdeer zoxide;
  };

  flake.modules.homeManager.homePackages = {pkgs, ...}: {
    home.packages = with pkgs.unstable;
      [
        # Tools
        eza
        bat
        gopass
        manix
        trash-cli
        fd
        yazi
        miller
        onefetch
        moreutils
        imagemagick
        (lib.hiPrio parallel)
        (ripgrep.override {withPCRE2 = true;})

        # Compression
        zip
        xz
        zstd
        unzipNLS
        p7zip

        # File Transfers
        s5cmd
        rsync
        croc

        # Misc
        ctop
        plantuml-c4
        vault
        ffmpeg
        ani-cli
        pre-commit

        # GUI Apps
        discord
        obsidian
        dbeaver-bin
        sioyek
        winbox4
      ]
      ++ lib.optionals pkgs.stdenv.isLinux [telegram-desktop]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        # Tools
        m-cli
        numi
        stats

        # GUI Apps
        terminal-notifier
        pinentry_mac

        # Brew
        pkgs.brewCasks.neohtop
        pkgs.brewCasks.mac-mouse-fix
        pkgs.brewCasks.telegram
        (pkgs.brewCasks.raindropio.overrideAttrs (o: {
          unpackPhase = let
            volumeName = "Raindrop.io ${o.version}-${pkgs.stdenv.hostPlatform.darwinArch}";
          in ''
            # Since the .dmg is using APFS we can't use undmg.
            # I also tried to use _7zz but it corrupts the .app.
            /usr/bin/hdiutil attach $src
            cp -r "/Volumes/${volumeName}/Raindrop.io.app" .
            /usr/bin/hdiutil detach "/Volumes/${volumeName}"
          '';
          installPhase = ''
            mkdir -p "$out/Applications/${o.sourceRoot}"
            cp -R . "$out/Applications/${o.sourceRoot}"
          '';
        }))
        (pkgs.brewCasks.wine-stable.overrideAttrs (o: {
          unpackPhase = "${lib.getExe pkgs.gnutar} -xvf $src";
        }))
        (pkgs.brewCasks.alfred.overrideAttrs (o: {
          unpackPhase = "${lib.getExe pkgs.gnutar} -xvzf $src";
        }))
      ];
  };

  flake.modules.homeManager.tools = {pkgs, ...}: {
    imports =
      [
        fzf
        nh
        starship
        tealdeer
        zoxide
      ]
      ++ [inputs.self.modules.homeManager.homePackages];
  };
}
