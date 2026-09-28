{inputs, ...}: {
  flake.modules.nixos.luffy = {
    lib,
    config,
    ...
  }: {
    imports = with inputs.self.modules.nixos; [
      nemexur
    ];

    users.users.nemexur = {
      description = config.systemConstants.userFullName;
      extraGroups = ["audio" "networkmanager" "podman"];
    };

    home-manager.users.nemexur = {
      home.sessionVariables = {
        "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
        "ELECTRON_OZONE_PLATFORM_HINT" = "auto"; # enable native Wayland support for most Electron apps
      };

      imports = with inputs.self.modules.homeManager;
        [
          # System
          gaming
          networkmanager

          # Browsers
          chromium
          firefox
          zen-browser

          # Programs
          niri
          noctalia
          tools
          localBin
          neovim
          git
          media
          terminal
          tmux
          zsh
          k8s

          # AI
          claude-code
          codex
          opencode
          pi-coding-agent

          # Services
          cron
          kdeconnect
          hypridle
          gnupg

          # Settings
          xdg

          # Secrets
          agenix
          age-rekey
          luffy-secret
        ]
        ++ (with inputs.self.modules.generic; [
          systemConstants
        ])
        ++ [
          {
            homeXDGSettings = {
              terminal = ["com.mitchellh.ghostty.desktop" "kitty.desktop"];
              browser = ["zen-beta.desktop" "firefox.desktop" "google-chrome.desktop"];
              editor = ["nvim.desktop"];
              imageViewer = ["gwenview.desktop"];
              pdfViewer = ["sioyek.desktop"];
              video = ["mpv.desktop" "vlc.desktop"];
              inode = ["yazi.desktop"];
            };
          }
          {
            homeHypridleSettings = {
              lockCmd = "noctalia-shell ipc call lockScreen lock";
            };
          }
        ];
    };
  };
}
