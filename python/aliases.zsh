alias jupstart='jupyter lab'
alias crvenv='python3 -m venv'

setKernel() {
    pip install ipykernel
    python -m ipykernel install --user --name "$1" --display-name "$2"
}
jupstartscr() {
    echoInfo "Creating screen `cur_dir`_screen"
    screen -dmS `cur_dir`_screen jupyter lab
}
launchvenv() {
    source "$1"/bin/activate
}
