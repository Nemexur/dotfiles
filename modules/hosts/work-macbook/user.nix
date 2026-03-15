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
          chrome
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

          # Services
          gnupg
          karabiner

          # Secrets
          agenix
          work-macbook-secrets
        ]
        ++ (with inputs.self.modules.generic; [
          systemConstants
          secrets
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
