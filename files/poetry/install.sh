#!/usr/bin/env bash
#
# Poetry
#
# This installs some poetry to manage dependencies in Python.

if test ! $(which poetry); then
  echo " Installing Poetry "
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
else
  echo " Poetry is already installed. "
fi

exit 0
