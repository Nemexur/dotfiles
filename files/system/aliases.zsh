alias clr='clear'

alias type="type -a"
alias mkdir="mkdir -p"
alias c='cd'
alias cz='zi'
alias cs='cd_with_fzf'
alias g='rg'
alias f='fd'
alias s='sed'
alias a='awk'
alias cat='bat'
alias df='duf'
alias du='ncdu'
alias vim='nvim'
alias vi='nvim --clean'
alias rm='trash'
alias lgit='lazygit'
alias ls='eza --icons --color=always'
alias ll='eza --icons --color=always -l'
alias la='eza --icons --color=always -la'
alias lt='eza --icons --color=always -T'
alias ssh='tmux-ssh'
alias pass='gopass'
alias pinentry='pinentry-mac'
alias tnotif='terminal-notifier'
alias icat='kitty icat --align left'

# macOS utils everywhere
if [[ "$OSTYPE" == darwin* ]]; then
	alias o='open'
elif [[ "$OSTYPE" == cygwin* ]]; then
	alias o='cygstart'
	alias pbcopy='tee > /dev/clipboard'
	alias pbpaste='cat /dev/clipboard'
elif [[ "$OSTYPE" == linux-android ]]; then
	alias o='termux-open'
	alias pbcopy='termux-clipboard-set'
	alias pbpaste='termux-clipboard-get'
else
	alias o='xdg-open'

	if [[ -n $DISPLAY ]]; then
		if (($ + commands[xclip])); then
			alias pbcopy='xclip -selection clipboard -in'
			alias pbpaste='xclip -selection clipboard -out'
		elif (($ + commands[xsel])); then
			alias pbcopy='xsel --clipboard --input'
			alias pbpaste='xsel --clipboard --output'
		fi
	else
		if (($ + commands[wl - copy] && $ + commands[wl - paste])); then
			alias pbcopy='wl-copy'
			alias pbpaste='wl-paste'
		fi
	fi
fi
alias pbc='pbcopy'
alias pbp='pbpaste'
