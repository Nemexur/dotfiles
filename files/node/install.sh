#!/usr/bin/env bash
#
# Node
#
# This installs some of the needed packages from npm.

if ! command -v spoof &> /dev/null; then
  npm install spoof -g
else
  echo " [SKIP] Spoof is already installed. "
fi

exit 0
