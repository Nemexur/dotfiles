{
  config,
  lib,
  ...
}: let
  options = [
    "EXTENDED_GLOB"
    "NO_BG_NICE" # don't nice background tasks
    "NO_HUP"
    "NO_LIST_BEEP"
    "LOCAL_OPTIONS" # allow functions to have local options
    "LOCAL_TRAPS" # allow functions to have local traps
    "PROMPT_SUBST"
    "CORRECT"
    "COMPLETE_IN_WORD"
    "IGNORE_EOF"
    "APPEND_HISTORY" # adds history
    "INC_APPEND_HISTORY"
    "SHARE_HISTORY" # adds history incrementally and share it across sessions
  ];
  envVariables = {
    LSCOLORS = "exfxcxdxbxegedabagacad";
    CLICOLOR = true;
    GPG_TTY = "$(tty)";
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    MANPAGER = "nvim +Man!";
    FZF_DEFAULT_OPTS = "--bind=ctrl-n:down,ctrl-p:up,ctrl-y:accept";
    DOTFILES = "${config.home.homeDirectory}/.dotfiles";
    MANPATH = "/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$(manpath -q)";
  };
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
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "emacs";
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "cursor" "brackets"];
      styles = highlightStyles;
    };
    setOptions = options;
    localVariables = {
      KEYTIMEOUT = 25;
      DEFAULT_USER = "$(whoami)";
    };
    sessionVariables = envVariables;
    # antidote = {
    #   enable = true;
    #   plugins = [
    #       "belak/zsh-utils path:completions"
    #   ];
    # };
    initContent = let
      zshExtraCompletions = lib.mkOrder 1000 ''
        #
        # tmux-ssh
        #
        _ssh_comp() {
            emulate -L zsh
            local service=ssh
            _ssh "$@"
        }

        compdef _ssh_comp tmux-ssh

        #
        # s5cmd
        #
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

        compdef _s5cmd_cli_zsh_autocomplete s5cmd
      '';
      zshConfig = lib.mkOrder 1500 ''
        bindkey -e
        bindkey -r '^l'
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
      '';
    in
      lib.mkMerge [zshExtraCompletions zshConfig];
  };
}
