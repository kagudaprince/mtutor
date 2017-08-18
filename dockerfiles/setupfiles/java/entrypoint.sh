#!/bin/bash

SECRETS_DIR=/etc/secrets
COMMAND=$1; shift
ARGS=$@

export_vars() {
  while IFS= read -r LINE || [[ -n "$LINE" ]]; do
    export $(echo $LINE)
  done < $1
}

recurse_dir() {
  if [ "$(ls -A $1)" ]; then
    local SECRET
    for SECRET in $1/*; do
      if [ -d $SECRET ]; then
        recurse_dir $SECRET
      else
        export_vars $SECRET
      fi
    done
  fi
}

if  [ -d $SECRETS_DIR ]; then
  recurse_dir $SECRETS_DIR
fi

exec $COMMAND $ARGS
