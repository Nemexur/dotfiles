export PATH="./bin:/usr/local/bin/node:/usr/local/bin:/usr/local/sbin:$DOTFILES/files/bin:$HOME/.local/bin:$HOME/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export CDPATH=.:..:$HOME:$GOROOT/src:$GOPATH/src/golang.org:$GOPATH/src/github.com
# GNU tools
if [[ "${OSTYPE}" == "darwin"* ]]; then
	export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gawk/libexec/gnubin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gnu-getopt/bin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gnu-indent/libexec/gnubin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gnu-time/libexec/gnubin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gnu-which/libexec/gnubin:$PATH"
	export PATH="${HOMEBREW_PREFIX}/opt/gnu-units/libexec/gnubin:$PATH"
fi
