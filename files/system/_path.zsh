export PATH="${PATH}:./bin:/usr/local/bin/node:/usr/local/bin:/usr/local/sbin:$DOTFILES/files/bin:$ZSH/bin"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    export PATH="${PATH}:/home/linuxbrew/.linuxbrew/bin"
fi
