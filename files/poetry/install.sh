#!/usr/bin/env bash
#
# Poetry
#
# This installs some poetry to manage dependencies in Python.

if ! command -v poetry &> /dev/null; then
  echo " Installing Poetry "
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
else
  echo " Poetry is already installed. "
fi

exit 0
