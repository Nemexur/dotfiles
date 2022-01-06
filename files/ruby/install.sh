#!/usr/bin/env bash
#
# Colorls
#
# This installs colorls for beutiful formatting in terminal.

if test ! $(which colorls); then
  echo " Installing colorls "
  gem install colorls -n /usr/local/bin
else
  echo " colorls is already installed. "
fi

exit 0
