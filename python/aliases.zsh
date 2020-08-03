alias jupstart='jupyter lab'
alias jupstartpoetry='poetry run jupyter lab'

# Virtual Environment
crvenv() {
    local python_ver=3
    local venv_nm=venv
    while [[ "$#" -gt 0 ]]
    do
        case $1 in
        -v|--version) local python_ver=${2:-3} ;;
        -n|--name) local venv_nm=${2:-venv} ;;
        esac
        shift
    done
    python$python_ver -m venv $venv_nm
}
crpoetry() {
    local name=project
    local python_ver=3.7.3
    while [[ "$#" -gt 0 ]]
    do
        case $1 in
        -v|--version) local python_ver=${2:-3.7.3} ;;
        -n|--name) local name=${2:-project} ;;
        esac
        shift
    done
    pyenv install -s $python_ver
    pyenv local $python_ver
    poetry new $name
}
launchvenv() {
    source "$1"/bin/activate
}
# iPython Kernel
setkernel() {
    pip install ipykernel
    python -m ipykernel install --user --name "$1" --display-name "$2"
}
poetrykernel() {
    poetry add -D ipykernel
    poetry run python -m ipykernel install --user --name "$1"
}
# Jupyter
jupscrpoetry() {
    echoInfo "Creating screen `cur_dir`_screen"
    screen -dmS `cur_dir`_screen poetry run jupyter lab
}
jupscr() {
    echoInfo "Creating screen `cur_dir`_screen"
    screen -dmS `cur_dir`_screen jupyter lab
}
