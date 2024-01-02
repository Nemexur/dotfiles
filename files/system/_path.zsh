export PATH="${PATH}:./bin:/usr/local/bin/node:/usr/local/bin:/usr/local/sbin:$DOTFILES/files/bin:$ZSH/bin:$HOME/.local/bin:$HOME/bin"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export CDPATH=.:..:$HOME:$GOROOT/src:$GOPATH/src/golang.org:$GOPATH/src/github.com
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    export PATH="${PATH}:/home/linuxbrew/.linuxbrew/bin"
fi
# GNU tools
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-indent/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-time/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-which/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-units/libexec/gnubin:$PATH"
