brew_install() {
    local package="$(brew formulae | fzf -m --preview="HOMEBREW_COLOR=true brew info {}" --preview-window=:hidden --bind="tab:toggle-preview")"
    if [[ -n $package ]]; then
        brew install $package
    fi
}

brew_install_cask() {
    local cask="$(brew casks | fzf -m --preview="HOMEBREW_COLOR=true brew info --cask {}" --preview-window=:hidden --bind="tab:toggle-preview")"
    if [[ -n $cask ]]; then
        brew install --cask $cask
    fi
}

alias 'bi'='brew_install'
alias 'bic'='brew_install_cask'
