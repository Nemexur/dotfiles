#!/bin/bash
set -eou pipefail

source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/Nemexur/dotfiles/master/scripts/prompt)"

brewInstall () {
    # Install brew
    if test ! $(which brew); then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        success "Homebrew installed"
    else
        info "Homebrew is already installed"
    fi
}

brewUpdate () {
    brew upgrade && brew update
    success "Homebrew updated"
}

xcodeSelectInstall() {
    xcode-select --install
}

ansibleInstall () {
    brew install python@3.9 ansible ansible-lint molecule
    # Also install pexpect module
    pip3 install pexpect
    success "Ansible installed"
}

# xcode-select setup
xcodeSelectInstall

# brew setup
brewInstall
brewUpdate

# Ansible setup
ansibleInstall

# Pull down personal dotfiles
echo ""
read -p "Do you want to use Nemexur's dotfiles? y/n" -n 1 -r
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
    echo "Initiate dotfiles bootstrap..." && $HOME/.dotfiles/scripts/dot-bootstrap

    if [[ $? -eq 0 ]]
    then
        echo "Successfully configured your environment with Nemexur's macOS dotfiles..."
    else
        echo "Nemexur's macOS dotfiles were not applied successfully..." >&2
fi
else 
    echo ""
    echo "You chose not to apply Nemexur's macOS dotfiles. You will need to configure your environment manually..."
fi
