{
  flake.modules.homeManager.neovim = {
    pkgs,
    config,
    ...
  }: {
    xdg.configFile = let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      configPath = "${config.home.homeDirectory}/.dotfiles/modules/programs/neovim/_conf";
    in {
      "nvim".source = mkSymlink configPath;
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
      package = pkgs.unstable.neovim-unwrapped;
      extraPackages = with pkgs.unstable; [
        (ripgrep.override {withPCRE2 = true;})
        codespell
        curl
        fd
        fzf
        gcc
        git
        gnumake
        imagemagick
        lazygit
        libxml2
        lua
        luajitPackages.luarocks
        tree-sitter
        unzip
        wget

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
        hadolint
        docker-compose-language-service
        dockerfile-language-server

        # elixir
        elixir-ls

        # yaml
        gitlab-ci-ls
        yaml-language-server
        yamlfmt
        yamllint

        # go
        go
        gopls
        gotools
        gofumpt
        golines
        golangci-lint
        golangci-lint-langserver
        delve

        # markdown
        harper
        prettier
        markdown-toc
        markdownlint-cli2
        marksman

        # json
        jsonnet-language-server
        vscode-json-languageserver

        # lua
        lua-language-server
        stylua

        # rust
        rustup

        # sql
        sqruff

        # vim
        vim-language-server

        # zig
        zls
      ];
    };
  };
}
