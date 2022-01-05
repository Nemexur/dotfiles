# Virtual Environment
crvenv() {
    local venv_nm=.venv
    local python_ver=3.7.3
    while [[ "$#" -gt 0 ]]
    do
        case $1 in
        -v|--version) local python_ver=${2:-3} ;;
        -n|--name) local venv_nm=${2:-.venv} ;;
        esac
        shift
    done
    pyenv install -s $python_ver
    pyenv local $python_ver
    python -m venv $venv_nm
}

launchvenv() {
    local venv_nm=${1:-.venv}
    source "$venv_nm"/bin/activate
}


# iPython Kernel
setkernel() {
    if [ -f pyproject.toml ]; then
        poetry add --dev ipykernel
    elif [ -f Pipfile ]; then
        pipenv install --dev ipykernel
    else
        pip install ipykernel
    fi
    source $1/bin/activate
    python -m ipykernel install --user --name $(echo "${PWD##*/}")-venv
    deactivate
}


# Jupyter
jupstart() {
    if [ -f pyproject.toml ]; then
        poetry run jupyter lab
    elif [ -f Pipfile ]; then
        pipenv run jupyter lab
    else
        jupyter lab
    fi
}

jupscr() {
    echoInfo "Creating screen $(cur_dir)-screen"
    if [ -f pyproject.toml ]; then
        screen -dmS $(cur_dir)-screen poetry run jupyter lab
    elif [ -f Pipfile ]; then
        screen -dmS $(cur_dir)-screen pipenv run jupyter lab
    else
        screen -dmS $(cur_dir)-screen jupyter lab
    fi
}
