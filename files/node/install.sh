#!/usr/bin/env bash
#
# Node
#
# This installs some of the needed packages from npm.

if ! command -v spoof &> /dev/null; then
  npm install -g spoof
else
  echo " [SKIP] Spoof is already installed. "
fi

if ! command -v prettier &> /dev/null; then
  npm install -g prettier @prettier/plugin-php prettier-plugin-solidity
else
  echo " [SKIP] Prettier is already installed. "
fi

exit 0
