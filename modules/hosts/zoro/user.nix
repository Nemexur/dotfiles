{inputs, ...}: {
  flake.modules.darwin.zoro = {
    imports = with inputs.self.modules.darwin; [
      nemexur
    ];

    home-manager.users.nemexur = {
      imports = with inputs.self.modules.homeManager;
        [
          # Browsers
          chromium
          zen-browser

          # Programs
          tools
          localBin
          neovim
          git
          terminal
          tmux
          zsh
          media
          k8s

          # AI
          claude-code
          codex
          opencode
          pi-coding-agent

          # Services
          cron
          gnupg
          karabiner

          # Secrets
          agenix
          age-rekey
        ]
        ++ (with inputs.self.modules.generic; [
          systemConstants
        ])
        ++ [
          {
            homeZenBrowser = {
              enableVaapi = false;
              useWayland = false;
              disableGpuCompositing = false;
            };
          }
        ];
    };
  };
}
