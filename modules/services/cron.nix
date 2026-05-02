let
  tmuxCleanDeadSessions = let
    linux = {
      lib,
      pkgs,
      config,
      ...
    }: {
      config = lib.mkIf pkgs.stdenv.isLinux {
        systemd.user.services.tmux-clean-sessions = {
          Unit.Description = "Clean old and inactive tmux sessions";
          Service = {
            Type = "oneshot";
            Environment = [
              ''PATH=${lib.strings.join ":" [
                  "/etc/profiles/per-user/${config.home.username}/bin"
                  "/run/current-system/sw/bin"
                  "/usr/local/bin"
                  "/usr/bin"
                  "/bin"
                  "/usr/sbin"
                  "/sbin"
                ]}''
            ];
            ExecStart = lib.strings.join " " [
              "${config.home.homeDirectory}/.local/bin/tmux-kill-session"
              "-v"
              "--filter"
              "dotfiles|ssh|skip"
              "--inactive-mins-max"
              "720"
            ];
          };
        };

        systemd.user.timers.tmux-clean-sessions = {
          Unit.Description = "Run tmux-clean-sessions every 3 hours";
          Timer = {
            OnCalendar = "*-*-* 00/3:00:00";
            Persistent = true;
            Unit = "tmux-clean-sessions.service";
          };
          Install.WantedBy = ["timers.target"];
        };
      };
    };
    darwin = {
      lib,
      pkgs,
      config,
      ...
    }: {
      config = lib.mkIf pkgs.stdenv.isDarwin {
        launchd.agents.tmux-clean-sessions = {
          enable = true;
          config = {
            Program = "${config.home.homeDirectory}/.local/bin/tmux-kill-session";
            ProgramArguments = [
              "-v"
              "--filter"
              "dotfiles|ssh|skip"
              "--inactive-mins-max"
              "720"
            ];
            EnvironmentVariables.PATH = lib.strings.join ":" [
              "/etc/profiles/per-user/${config.home.username}/bin"
              "/run/current-system/sw/bin"
              "/usr/local/bin"
              "/usr/bin"
              "/bin"
              "/usr/sbin"
              "/sbin"
            ];
            StartInterval = 3 * 60 * 60; # 3 hours
            RunAtLoad = true;

            StandardOutPath = "/tmp/tmux-clean-sessions-stdout.txt";
            StandardErrorPath = "/tmp/tmux-clean-sessions-stderr.txt";
          };
        };
      };
    };
  in {
    imports = [linux darwin];
  };
in {
  flake.modules.homeManager.cron = {
    imports = [tmuxCleanDeadSessions];
  };
}
