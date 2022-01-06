#!/usr/bin/env bash
#
# VSCode
#
# This installes extenstions for VSCode.

if test $(which code); then
    # Themes
    code --install-extension dracula-theme.theme-dracula
    code --install-extension Equinusocio.vsc-material-theme
    code --install-extension PKief.material-icon-theme
    # Code
    code --install-extension formulahendry.code-runner
    code --install-extension streetsidesoftware.code-spell-checker
    code --install-extension streetsidesoftware.code-spell-checker-russian
    code --install-extension austin.code-gnu-global
    code --install-extension aaron-bond.better-comments
    code --install-extension esbenp.prettier-vscode
    code --install-extension Gruntfuggly.todo-tree
    code --install-extension mattn.Lisp
    # Remote
    code --install-extension ms-vscode-remote.remote-ssh
    code --install-extension ms-vscode-remote.remote-ssh-edit
    code --install-extension ms-vscode-remote.remote-containers
    # Python
    code --install-extension ms-python.python
    code --install-extension KevinRose.vsc-python-indent
    code --install-extension ms-python.vscode-pylance
    code --install-extension dawhite.mustache
    code --install-extension njpwerner.autodocstring
    code --install-extension ms-toolsai.jupyter
    # Golang
    code --install-extension golang.go
    code --install-extension 766b.go-outliner
    code --install-extension premparihar.gotestexplorer
    # C++
    code --install-extension danielpinto8zz6.c-cpp-compile-run
    code --install-extension ms-vscode.cpptools
    # Latex
    code --install-extension ajshort.latex-preview
    code --install-extension James-Yu.latex-workshop
    code --install-extension Jeff-Tian.tex-workshop
    code --install-extension nickfode.latex-formatter
    code --install-extension tecosaur.latex-utilities
    code --install-extension torn4dom4n.latex-support
    code --install-extension twday.bibmanager
    # Jsonnet
    code --install-extension heptio.jsonnet
    code --install-extension xrc-inc.jsonnet-formatter
    # For VSCode
    code --install-extension vscodevim.vim
    code --install-extension DavidAnson.vscode-markdownlint
    code --install-extension sensourceinc.vscode-sql-beautify
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
    code --install-extension redhat.vscode-yaml
    code --install-extension zxh404.vscode-proto3
    code --install-extension ionutvmi.path-autocomplete
    # Git
    code --install-extension donjayamanne.githistory
    code --install-extension eamodio.gitlens
    # Other
    code --install-extension ericadamski.carbon-now-sh
    code --install-extension GrapeCity.gc-excelviewer
    code --install-extension shd101wyy.markdown-preview-enhanced
    code --install-extension randrade23.beautify-json
else
    echo " Visual Studio Code is not installed. "
fi

exit 0
