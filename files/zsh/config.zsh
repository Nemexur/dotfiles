fpath=($DOTFILES/files/functions $fpath)

HISTFILE=~/.zsh_history
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

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS   # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY    # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY                   # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS             # don't record dupes in history
setopt HIST_SAVE_NO_DUPS                # don't record dupes in history
setopt HIST_IGNORE_DUPS                 # don't record dupes in history
setopt HIST_IGNORE_SPACE                # ignore commands with space prefix
setopt HIST_REDUCE_BLANKS

bindkey -e
bindkey -r '^l'
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

fancy-ctrl-z() {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

cd-with-fzf() {
	cd_with_fzf
	zle accept-line
}
zle -N cd-with-fzf
bindkey '^[d' cd-with-fzf

timezsh() {
	shell=${1-$SHELL}
	for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
	FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
fi
