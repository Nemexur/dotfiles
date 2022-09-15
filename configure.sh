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
}

brewUpdate () {
    brew upgrade && brew update
    success "Homebrew updated"
}

xcodeSelectInstall() {
    xcode-select --install || true
}

pythonInstall() {
    sudo apt-get update
    info "Add python repository"
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends python3-apt python3-pip python3.10 python3.10-dev
    info "Update default python/python3 version"
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
    info "Install pip"
    wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py && python get-pip.py && rm get-pip.py
    export PATH=${HOME}/.local/bin:${PATH}
    pip install -U setuptools wheel
}

ansibleInstall () {
    if [[ "${OSTYPE}" == "darwin"* ]]; then
        brew install python@3.9 ansible ansible-lint molecule
    elif [[ "${OSTYPE}" == "linux-gnu"* ]]; then
        pip install ansible ansible-lint molecule
    fi
    success "Ansible installed"
}

if [[ "${OSTYPE}" == "darwin"* ]]; then
    # xcode-select setup
    xcodeSelectInstall

    # brew setup
    brewInstall
    brewUpdate
elif [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    pythonInstall
    read -p "Do you want to install homebrew? [y/n] " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brewInstall
        brewUpdate
    fi
fi

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
