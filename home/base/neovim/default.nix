{
  config,
  pkgs-unstable,
  ...
}: {
  xdg.configFile = let
    mkSymlink = config.lib.file.mkOutOfStoreSymlink;
    configPath = "${config.home.homeDirectory}/.dotfiles/home/base/neovim/nvim";
  in {
    "nvim".source = mkSymlink configPath;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    extraPackages = with pkgs-unstable; [
      git
      gcc
      gnumake
      unzip
      wget
      curl
      tree-sitter
      (ripgrep.override {withPCRE2 = true;})
      fd
      fzf
      cargo
      lazygit
      python3
      luajitPackages.luarocks
      lua
      libxml2
      imagemagick

      # nix
      nil
      alejandra

      # ansible
      ansible-language-server
      ansible-lint

      # bash
      bash-language-server
      shellcheck
      shfmt

      # python
      ruff
      pyright
      poetry
      uv
      black
      python314Packages.flake8
      isort
      ty

      # protobuf
      buf

      # c
      clang-tools
      glib

      # docker
      docker-compose-language-service
      dockerfile-language-server

      # elixir
      elixir-ls

      # yaml
      prettier
      gitlab-ci-ls
      yaml-language-server
      yamlfmt
      yamllint

      # go
      go
      gopls
      gotools
      gofumpt
      gotools
      golines
      golangci-lint
      golangci-lint-langserver
      delve

      # markdown
      harper
      markdown-toc
      markdownlint-cli
      marksman

      # json
      vscode-json-languageserver
      go-jsonnet
      jsonnet-language-server

      # lua
      lua-language-server
      stylua

      # rust
      cargo
      rustc
      rustfmt
      rust-analyzer
      clippy

      # sql
      python314Packages.sqlfmt

      # vim
      vim-language-server

      # zig
      zls
    ];
  };
}
