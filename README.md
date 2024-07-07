# Dotfiles

[![Test][badge-gh-actions]][link-gh-actions]

## Installation

Run the following command to install dotfiles from scratch:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Nemexur/dotfiles/main/install.sh) "${HOME}/.dotfiles"
```

Additionally, the installation script has a dry-run option, which can be enabled by adding the `-d/--dry-run` option.

## Components

**The hierarchy is inspired by [Holman's dotfiles repository](https://github.com/holman/dotfiles).**
There are a few particular files in the hierarchy:

- **bin/**: Anything in `bin/` will be added to your `$PATH` and
  be available everywhere.
- **roles/**: Ansible roles to install system configuration.
- **tasks/**: Special ansible-playbook scripts for system maintenance.
- **vars/**: Variables for tasks in ansible-playbook.
- **tests/**: In contains 2 folders: `ci` and `vagrant`. The first one is used
  for github-workflows. The second one is used for local testing with VirtualBox.
- **files/{topic}/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **files/{topic}/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **files/{topic}/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **files/{topic}/install.yaml**: Any file named `install.yaml` is executed when you run `dot installs`. These are specific installation scripts for topics.
- **files/{topic}/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `dot symlinks`.

## Running tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags to `dot` shell script. Available tags:

- packages
- system
- git
- terminal
- zsh
- tmux
- ranger
- editors
- vim
- vscode
- lunarvim
- emacs
- filesystem
- symlink
- install
- misc

```bash
dot packages system
```

**If tags are not specified, everything is enabled.**

[badge-gh-actions]: https://github.com/Nemexur/dotfiles/actions/workflows/ci.yml/badge.svg?branch=main&event=push
[link-gh-actions]: https://github.com/Nemexur/dotfiles/actions/workflows/ci.yml
