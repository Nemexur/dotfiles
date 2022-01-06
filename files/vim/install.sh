#!/usr/bin/env bash
#
# Vim
#
# This installs vim dependencies to make it cool.

if test $(which vim); then
  vim -c 'BundleInstall' -c 'qa!'
fi

exit 0
