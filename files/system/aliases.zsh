# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`

alias cd='z'
alias cdi='zi'
alias cat='bat'
alias ls='exa --icons --color=always'
alias ll='exa --icons --color=always -l'
alias la='exa --icons --color=always -la'

alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
alias config='/usr/bin/git --git-dir=/Users/$(whoami)/.cfg/ --work-tree=/Users/$(whoami)'
alias cur_dir='echo ${PWD##*/}'
alias chsize='ls -lh'
alias chdirsize='du -hs'
alias topndir='du -sxh ./* | sort -rh'
alias isscreen='echo $STY'
alias chnumber='ls -1 | wc -l'
