#!/usr/bin/env bash
#
# Node
#
# This installs some of the needed packages from npm.

if test ! $(which spoof)
then
  npm install spoof -g
fi
