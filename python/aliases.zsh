alias jupstart='jupyter lab'

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
setkernel() {
    pip install ipykernel
    python -m ipykernel install --user --name "$1" --display-name "$2"
}
jupscr() {
    echoInfo "Creating screen `cur_dir`_screen"
    screen -dmS `cur_dir`_screen jupyter lab
}
launchvenv() {
    source "$1"/bin/activate
}
