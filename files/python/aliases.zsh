launchvenv() {
    local venv_nm=${1:-.venv}
    source "$venv_nm"/bin/activate
}


# iPython Kernel
setkernel() {
    if [ -f pyproject.toml ]; then
        poetry add --group dev ipykernel
    else
        pip install ipykernel
    fi
    source .venv/bin/activate
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
