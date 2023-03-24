open_with_fzf() {
    fd -t f -H -I --strip-cwd-prefix --full-path ${HOME} | fzf -m | xargs open
}

cd_with_fzf() {
    local dir="$(fd -t d -I --strip-cwd-prefix --full-path ${HOME} | fzf --preview="tree -L 1 {}" --bind="tab:toggle-preview" --preview-window=:hidden)"
    if [[ -n $dir ]]; then
        cd $dir
    fi
}

pass_with_fzf() {
    local password="$(gopass ls --flat | fzf -m)" 
    if [[ -n $password ]]; then
        gopass show -c $password 2>/dev/null
    fi
}

