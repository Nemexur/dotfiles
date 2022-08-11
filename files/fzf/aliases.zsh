open_with_fzf() {
    CUR_DIR=${PWD}
    cd ${HOME} && fd -t f -H -I --strip-cwd-prefix | fzf -m | xargs open
    cd ${CUR_DIR}
}

cd_with_fzf() {
    local cur_dir=${PWD}
    cd ${HOME}
    local dir="$(fd -t d --strip-cwd-prefix | fzf --preview="tree -L 1 {}" --bind="tab:toggle-preview" --preview-window=:hidden)"
    if [[ -n $dir ]]; then
        cd $dir
    else
        cd $cur_dir
    fi
}

pass_with_fzf() {
    local password="$(gopass ls --flat | fzf -m)" 
    if [[ -n $password ]]; then
        gopass show -c $password 2>/dev/null
    fi
}

_brew_install() {
    local package="$(brew formulae | fzf -m --preview="HOMEBREW_COLOR=true brew info {}" --preview-window=:hidden --bind="tab:toggle-preview")"
    if [[ -n $package ]]; then
        brew install $package
    fi
}

_brew_install_cask() {
    local cask="$(brew casks | fzf -m --preview="HOMEBREW_COLOR=true brew info --cask {}" --preview-window=:hidden --bind="tab:toggle-preview")"
    if [[ -n $cask ]]; then
        brew install --cask $cask
    fi
}

brew_install() {
    source $HOME/.dotfiles/scripts/prompt

    ask_user " - Select type of brew formula?\n\
     [\033[00;32m1\033[0m] Package\n\
     [\033[00;32m2\033[0m] Cask\n\
     >"
    read -r action
    echo ""
    case $action in
        1 )
            _brew_install
            ;;
        2 )
            _brew_install_cask
            ;;
        * )
            fail "Invalid user input."
            ;;
    esac
}

