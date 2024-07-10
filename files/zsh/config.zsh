KEYTIMEOUT=25
DEFAULT_USER="$(whoami)"
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTFILESIZE=10000
HISTCONTROL=ignoredups

# ZSH Vi Mode settings
ZVM_KEYTIMEOUT=0.1
ZVM_INIT_MODE=sourcing
ZVM_CURSOR_STYLE_ENABLED=false
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE

# ZSH Dotenv
ZSH_DOTENV_PROMPT=false

# Set Open Files limits
ulimit -n 200000
ulimit -u 2048

setopt EXTENDED_GLOB
setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS   # allow functions to have local traps
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY                   # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY # adds history incrementally and share it across sessions

bindkey -e
bindkey -r '^l'
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
