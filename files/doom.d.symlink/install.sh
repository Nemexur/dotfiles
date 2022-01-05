if [ -d $HOME/.emacs.d/bin && -d $HOME/.doom.d ]; then
  echo " Updating Doom Emacs configuration. "

  $HOME/.emacs.d/bin/doom sync -up
  $HOME/.emacs.d/bin/doom clean
  $HOME/.emacs.d/bin/doom env
  $HOME/.emacs.d/bin/doom doctor
else
  echo " Doom Emacs is not installed. "
fi

exit 0
