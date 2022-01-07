#!/usr/bin/env bash
#
# Doom Emacs
#
# This installs and configures packages from symlinked doom.d directory.

if [[ -d "$HOME/.emacs.d/bin" && -d "$HOME/.doom.d" ]]; then
  echo " Updating Doom Emacs configuration. "

  $HOME/.emacs.d/bin/doom sync -up
  $HOME/.emacs.d/bin/doom clean
  $HOME/.emacs.d/bin/doom env
  # Just in case make doom doctor always succedd.
  $HOME/.emacs.d/bin/doom doctor || true
else
  echo " Doom Emacs is not installed. "
fi
