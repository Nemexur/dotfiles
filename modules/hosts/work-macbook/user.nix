{inputs, ...}: {
  flake.modules.darwin.work-macbook = {
    lib,
    config,
    ...
  }: {
    imports = [
      inputs.self.modules.darwin."a.n.milogradskiy"
    ];

    home-manager.users."a.n.milogradskiy" = {
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
          work-macbook-secret
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
