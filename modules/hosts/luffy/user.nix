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
      extraGroups = ["networkmanager" "podman"];
    };

    home-manager.users.nemexur = {
      imports = with inputs.self.modules.homeManager;
        [
          # System
          gaming
          networkmanager

          # Browsers
          chrome
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

          # Services
          kdeconnect
          hypridle
          gnupg

          # Settings
          xdg

          # Secrets
          agenix
          home-envs-secret
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

      home.sessionVariables = {
        "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
        "ELECTRON_OZONE_PLATFORM_HINT" = "auto"; # enable native Wayland support for most Electron apps
      };
    };
  };
}
