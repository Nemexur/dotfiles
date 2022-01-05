alias reload!='. ~/.zshrc'
alias clr='clear'
alias dot-bootstrap='$_ZSH/scripts/dot-bootstrap'

echoInfo () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
} 

echoSuccess () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

echoFail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}
