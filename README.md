# dotfiles

[![CI][badge-gh-actions]][link-gh-actions]

## Configuration

Run the following to configure macOS from scratch...

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Nemexur/dotfiles/main/configure.sh)
```

## Installation

  1. Ensure Apple's command line tools are installed (xcode-select --install to launch the installer).
  2. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html):

     1. Run the following command to add Python 3 to your $PATH: `export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH"`
     2. Upgrade Pip: `sudo pip3 install --upgrade pip`
     3. Install Ansible: `pip3 install ansible`

  3. Clone or download this repository to your local drive.
  4. Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
  5. Run `ansible-playbook main.yml --ask-become-pass or dot` inside this directory. Enter your macOS account password when prompted for the 'BECOME' password.

## Notes

Your dotfiles are how you personalize your system. These are mine.

I was a little tired of having long alias files and everything strewn about
(which is extremely common on other dotfiles projects, too). That led to this
project being much more topic-centric. I realized I could split a lot of things
up into the main areas I used (git, system libraries, and so on), so I
structured the project accordingly.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read Holman's post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## Topical

Everything's built around topic areas `files` folder. If you're adding a new
area to your forked dotfiles — say, "Java" — you can simply add a `java` directory
and put files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run
`dot --tags symlinks`.

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **handlers/**: Handlers to run in ansible-playbook.
- **scripts/**: Special scripts like `dot` and `prompt` to configure
  dotfiles and prompts respectively.
- **tasks/**: Tasks to run in ansible-playbook.
- **templates/**: A template is a file that contains all your configuration
  parameters, but the dynamic values are given as variables in the Ansible.
- **vars/**: Variables for tasks in ansible-playbook.
- **tests/**: In contains 2 folders: `ci` and `vagrant`. The first one is used
  for github-workflows. The second one is used for local testing with VirtualBox.
- **files/topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **files/topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **files/topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **files/topic/install.sh**: Any file named `install.sh` is executed when you run
  `ansible-playbook main.yml --ask-become-pass --tags installs`.
  To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **files/topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run
  `ansible-playbook main.yml --ask-become-pass --tags symlinks`.

## Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using ansible-playbook's --tags flag. The tags available are:

- homebrew
- gitconfig
- zsh
- tmux
- vim
- emacs
- creates
- symlinks
- installs
- macos
- extra

You can find configuration for each task in `tasks` folder.

```bash
ansible-playbook main.yml --ask-become-pass --tags "homebrew,installs"
```

## Extra

`dot` is a simple script that configures everything.
It is considered an alias for `ansible-playbook main.yml --ask-become-pass`.
However, it additionally checks for gitconfig files.

[badge-gh-actions]: https://github.com/Nemexur/dotfiles/actions/workflows/ci.yml/badge.svg?branch=main&event=push
[link-gh-actions]: https://github.com/Nemexur/dotfiles/actions/workflows/ci.yml
