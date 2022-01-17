# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`

# if $(gls &>/dev/null); then
#   alias ls="gls -F --color"
#   alias l="gls -lAh --color"
#   alias ll="gls -l --color"
#   alias la='gls -A --color'
# else
alias ll='colorls -la'
alias ls='colorls --sd'
alias la='colorls --sd -A'

alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
alias config='/usr/bin/git --git-dir=/Users/$(whoami)/.cfg/ --work-tree=/Users/$(whoami)'
alias cur_dir='echo ${PWD##*/}'
alias chsize='ls -lh'
alias chdirsize='du -hs'
alias topndir='du -sxh ./* | sort -rh'
alias isscreen='echo $STY'
alias chnumber='ls -1 | wc -l'
alias cat='bat'
