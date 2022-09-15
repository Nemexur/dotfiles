#!/bin/bash
set -eou pipefail

source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/Nemexur/dotfiles/main/scripts/prompt)"

brewInstall () {
    # Install brew
    if test ! $(which brew); then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        success "Homebrew installed"
    else
        info "Homebrew is already installed"
    fi
    if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
        export PATH=${PATH}:/home/linuxbrew/.linuxbrew/bin
    fi
}

brewUpdate () {
    brew upgrade && brew update
    success "Homebrew updated"
}

ansibleInstall () {
    brew install python@3.9 ansible ansible-lint molecule
    success "Ansible installed"
}

if [[ "${OSTYPE}" == "darwin"* ]]; then
    # xcode-select setup
    xcode-select --install || true
elif [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    sudo apt-get update || true
fi
# brew setup
brewInstall
brewUpdate

# Ansible setup
ansibleInstall

# Pull down personal dotfiles
echo ""
read -p "Do you want to use Nemexur's dotfiles? [y/n] " -n 1 -r
echo  # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    if [ -d "$HOME/.dotfiles" ]; then
        info "Nemexur dotfiles already installed"
    else
        echo "Now pulling down Nemexur dotfiles..." && git clone https://github.com/Nemexur/dotfiles.git ~/.dotfiles
    fi
    echo ""
    cd $HOME/.dotfiles && echo "Switched to .dotfiles dir..."
    echo ""
    echo "Initiate dotfiles bootstrap..." && $HOME/.dotfiles/files/bin/dot

    if [[ $? -eq 0 ]]
    then
        echo "Successfully configured your environment with Nemexur's dotfiles..."
    else
        echo "Nemexur's dotfiles were not applied successfully..." >&2
fi
else
    echo ""
    echo "You chose not to apply Nemexur's macOS dotfiles. You will need to configure your environment manually..."
fi
