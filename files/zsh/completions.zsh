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
        cur=${words[-1]}
        opts=("${(@f)$(${words[@]:0:#words[@]-1} "${cur}" --generate-bash-completion)}")

        if [[ "${opts[1]}" != "" ]]; then
          _describe 'values' opts
        else
          _files
        fi
}

compdef _s5cmd_cli_zsh_autocomplete s5cmd
