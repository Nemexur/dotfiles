{
  flake.modules.homeManager.zsh = {
    lib,
    pkgs,
    config,
    ...
  }: let
    envVariables = {
      CLICOLOR = true;
      DOTFILES = "${config.home.homeDirectory}/.dotfiles";
      EDITOR = "nvim";
      FZF_DEFAULT_OPTS = "--bind=ctrl-n:down,ctrl-p:up,ctrl-y:accept";
      LANG = "en_US.UTF-8";
      LSCOLORS = "exfxcxdxbxegedabagacad";
      MANPAGER = "nvim +Man!";
    };
    aliases =
      {
        a = "awk";
        c = "cd";
        cat = "bat";
        clr = "clear";
        d = "docker";
        df = "duf";
        dig = "doggo";
        du = "ncdu";
        f = "fd";
        g = "rg";
        gco = "git checkout";
        gs = "git status";
        icat = "kitty icat --align left";
        k = "kubectl";
        kctx = "kubectx";
        kns = "kubens";
        la = "eza --icons --color=always -la";
        lgit = "lazygit";
        ll = "eza --icons --color=always -l";
        ls = "eza --icons --color=always";
        lt = "eza --icons --color=always -T";
        mkdir = "mkdir -p";
        ns = "nix-shell --command 'zsh'";
        p = "podman";
        pass = "gopass";
        rm = "trash";
        s = "sed";
        ssh = "tmux-ssh";
        type = "type -a";
      }
      // (
        if pkgs.stdenv.isDarwin
        then {
          pbc = "pbcopy";
          pbp = "pbpaste";
          pinentry = "pinentry-mac";
          tnotif = "terminal-notifier";
        }
        else {
          open = "xdg-open";
          pbc = "wl-copy";
          pbp = "wl-paste";
        }
      );
    options = [
      "APPEND_HISTORY" # adds history
      "BANG_HIST" # Treat the '!' character specially during expansion.
      "COMPLETE_IN_WORD"
      "CORRECT"
      "EXTENDED_GLOB"
      "EXTENDED_HISTORY" # Write the history file in the ':start:elapsed;command' format.
      "HIST_BEEP" # Beep when accessing non-existent history.
      "HIST_EXPIRE_DUPS_FIRST" # Expire a duplicate event first when trimming history.
      "HIST_FIND_NO_DUPS" # Do not display a previously found event.
      "HIST_IGNORE_ALL_DUPS" # Delete an old recorded event if a new event is a duplicate.
      "HIST_IGNORE_DUPS" # Do not record an event that was just recorded again.
      "HIST_IGNORE_SPACE" # Do not record an event starting with a space.
      "HIST_SAVE_NO_DUPS" # Do not write a duplicate event to the history file.
      "HIST_VERIFY" # Do not execute immediately upon history expansion.
      "IGNORE_EOF"
      "INC_APPEND_HISTORY" # Write to the history file immediately, not when the shell exits.
      "LOCAL_OPTIONS" # allow functions to have local options
      "LOCAL_TRAPS" # allow functions to have local traps
      "NO_BG_NICE" # don't nice background tasks
      "NO_HUP"
      "NO_LIST_BEEP"
      "PROMPT_SUBST"
      "SHARE_HISTORY" # adds history incrementally and share it across sessions
    ];
    highlightStyles = {
      comment = "fg=#6272A4";
      # Constants
      # Entitites
      # Functions/methods
      alias = "fg=#50FA7B";
      suffix-alias = "fg=#50FA7B";
      global-alias = "fg=#50FA7B";
      function = "fg=#50FA7B";
      command = "fg=#50FA7B";
      precommand = "fg=#50FA7B,italic";
      autodirectory = "fg=#FFB86C,italic";
      single-hyphen-option = "fg=#FFB86C";
      double-hyphen-option = "fg=#FFB86C";
      back-quoted-argument = "fg=#BD93F9";
      # Keywords
      # Built ins
      builtin = "fg=#8BE9FD";
      reserved-word = "fg=#8BE9FD";
      hashed-command = "fg=#8BE9FD";
      # Punctuation
      commandseparator = "fg=#FF79C6";
      command-substitution-delimiter = "fg=#F8F8F2";
      command-substitution-delimiter-unquoted = "fg=#F8F8F2";
      process-substitution-delimiter = "fg=#F8F8F2";
      back-quoted-argument-delimiter = "fg=#FF79C6";
      back-double-quoted-argument = "fg=#FF79C6";
      back-dollar-quoted-argument = "fg=#FF79C6";
      # Serializable / Configuration Languages
      # Storage
      # Strings
      command-substitution-quoted = "fg=#F1FA8C";
      command-substitution-delimiter-quoted = "fg=#F1FA8C";
      single-quoted-argument = "fg=#F1FA8C";
      single-quoted-argument-unclosed = "fg=#FF5555";
      double-quoted-argument = "fg=#F1FA8C";
      double-quoted-argument-unclosed = "fg=#FF5555";
      rc-quote = "fg=#F1FA8C";
      # Variables
      dollar-quoted-argument = "fg=#F8F8F2";
      dollar-quoted-argument-unclosed = "fg=#FF5555";
      dollar-double-quoted-argument = "fg=#F8F8F2";
      assign = "fg=#F8F8F2";
      named-fd = "fg=#F8F8F2";
      numeric-fd = "fg=#F8F8F2";
      # No category relevant in spec
      unknown-token = "fg=#FF5555";
      path = "fg=#F8F8F2";
      path_pathseparator = "fg=#FF79C6";
      path_prefix = "fg=#F8F8F2";
      path_prefix_pathseparator = "fg=#FF79C6";
      globbing = "fg=#F8F8F2";
      history-expansion = "fg=#BD93F9";
      back-quoted-argument-unclosed = "fg=#FF5555";
      redirection = "fg=#F8F8F2";
      arg0 = "fg=#F8F8F2";
      default = "fg=#F8F8F2";
      cursor = "standout";
    };
  in {
    age.secrets.home-envs.rekeyFile = ./home-envs.age;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      completionInit = ''
        autoload -Uz compinit
        for dump in ~/.zcompdump(N.mh+24); do
          compinit
        done
        compinit -C
      '';
      autosuggestion.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      defaultKeymap = "emacs";
      setOptions = options;
      sessionVariables = envVariables;
      shellAliases = aliases;
      localVariables = {
        KEYTIMEOUT = 25;
        DEFAULT_USER = "$(whoami)";
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = ["main" "cursor" "brackets"];
        styles = highlightStyles;
      };
      plugins = [
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
        {
          name = "zsh-history-substring-search";
          src = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
        }
      ];
      initContent = let
        zshExtraCompletions = lib.mkOrder 560 ''
          #
          # Extra Completions
          #

          _ssh_comp() {
              emulate -L zsh
              local service=ssh
              _ssh "$@"
          }

          _s5cmd_cli_zsh_autocomplete() {
                  local -a opts
                  local cur
                  cur=''${words[-1]}
                  opts=("''${(@f)$(''${words[@]:0:#words[@]-1} "''${cur}" --generate-bash-completion)}")

                  if [[ "''${opts[1]}" != "" ]]; then
                    _describe 'values' opts
                  else
                    _files
                  fi
          }

          compdef _ssh_comp tmux-ssh
          compdef _s5cmd_cli_zsh_autocomplete s5cmd
        '';
        zshConfig = lib.mkOrder 1000 ''
          #
          # ZshConfig
          #

          bindkey -e
          bindkey -r '^l'
          bindkey '^p' history-substring-search-up
          bindkey '^n' history-substring-search-down
          bindkey "$terminfo[kcuu1]" history-substring-search-up
          bindkey "$terminfo[kcud1]" history-substring-search-down
        '';
        zshStyles = lib.mkOrder 1000 ''
          #
          # ZStyles
          #

          # Fix pasting speed
          # ref https://github.com/zsh-users/zsh-autosuggestions/issues/238
          zstyle ':bracketed-paste-magic' active-widgets '.self-*'

          # Disable sort when completing `git checkout`
          zstyle ':completion:*:git-checkout:*' sort false

          # Set descriptions format to enable group support
          zstyle ':completion:*:descriptions' format '[%d]'

          # Matches case insensitive for lowercase
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

          # Pasting with tabs doesn't perform completion
          zstyle ':completion:*' insert-tab pending

          # Make it colourful
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

          # Use fzf-tab for completions
          zstyle ':completion:*' menu no

          # Add preview to the completions
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
          zstyle ':fzf-tab:*' fzf-flags --bind=ctrl-n:down,ctrl-p:up,ctrl-y:accept
        '';
        zshGpgSshEnvs = lib.mkOrder 1100 ''
          export GPG_TTY="$(tty)"
          export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        '';
        zshHomeEnvs = lib.mkOrder 1100 ''
          if [ -f ${config.age.secrets.home-envs.path} ]; then
            source ${config.age.secrets.home-envs.path}
          fi
        '';
      in
        lib.mkMerge [
          zshExtraCompletions
          zshConfig
          zshStyles
          zshGpgSshEnvs
          zshHomeEnvs
        ];
    };

    programs.fzf.enableZshIntegration = true;
    programs.ghostty.enableZshIntegration = true;
    programs.zoxide.enableZshIntegration = true;
    programs.starship.enableZshIntegration = true;
  };
}
