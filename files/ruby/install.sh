#!/usr/bin/env bash
#
# Colorls
#
# This installs colorls for beutiful formatting in terminal.

if ! command -v colorls &> /dev/null; then
  echo " Installing colorls "
  sudo gem install colorls -n /usr/local/bin || true
else
  echo " [SKIP] Colorls is already installed. "
fi

