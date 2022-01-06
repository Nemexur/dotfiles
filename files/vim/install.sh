#!/usr/bin/env bash
#
# Vim
#
# This installs vim dependencies to make it cool.

if test $(which vim); then
  vim +BundleInstall +qall
fi

exit 0
