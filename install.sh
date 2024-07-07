#!/usr/bin/env bash

set -Eeuo pipefail

script_name=$(basename "${BASH_SOURCE[0]}")
args=(INSTALL_PATH)

usage() {
    cat << EOF
Install nemexur's dotfiles.

Usage: ${script_name} [OPTIONS] ${args[*]}

Options:
  -d, --dry-run    Validate the script
  -v, --verbose    Enable verbosity
  -h, --help       Print help
EOF
    exit
}

msg() {
    echo >&2 -e "${1-}"
}

die() {
    local msg=$1
    local code=${2-1}
    msg "${script_name}: ${msg}"
    exit "${code}"
}

parse_params() {
    while :; do
        case "${1-}" in
        -h | --help) usage ;;
        -d | --dry-run)
            dry_run=true
            ;;
        -v | --verbose)
            verbose=true
            ;;
        -?*) die "Unknown option: $1" ;;
        *) break ;;
        esac
        shift
    done
    argv=("$@")
    paste <(tr " " "\n" <<< "${args[@]}") <(tr " " "\n" <<< "${argv[@]:-""}") | while read -r arg value; do
        if [ -z "${value}" ]; then
            die "Missing argument: ${arg}"
        fi
    done
    return 0
}

run() {
    if ${dry_run}; then
        echo "$@"
        return 0
    fi
    if ${verbose}; then
        echo "$@"
    fi
    "$@"
}

verbose=false
dry_run=false

parse_params "$@"

install_path=${argv[0]}
export DOTFILES="${install_path}"
if ! command -v brew &> /dev/null; then
    run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
run brew update
run brew install python@3.11 python@3.12 ansible git
if [ ! -d "${install_path}" ]; then
    run git clone https://github.com/Nemexur/dotfiles.git "${install_path}"
fi
run ansible-galaxy install --role-file "${install_path}/requirements.yaml"
run ansible-playbook -K "${install_path}/main.yaml"
