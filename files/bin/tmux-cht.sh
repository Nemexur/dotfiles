#! /usr/bin/env bash

FILES_DIR="${DOTFILES}/files/cht.sh"

if test -f "${FILES_DIR}/list"; then
  LIST="${FILES_DIR}/list"
else
  curl -Ss https://cht.sh/:list > "${FILES_DIR}/list"
  LIST="${FILES_DIR}/list"
fi
ITEM="$(fzf --preview="bash cht.sh {}" < "${LIST}")"
if [ "$ITEM" == "" ]; then
  exit 0
fi
read -erp "Query for ${ITEM}: " QUERY
curl -s "cht.sh/${ITEM}~${QUERY//\ /+}?qT&style=bw" | ${EDITOR}
