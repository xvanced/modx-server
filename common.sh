#!/bin/bash

## Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

## Helper
exists() {
    command -v "$1" >/dev/null 2>&1
}

is_directory() {
  if [ -d "$1" ]
  then
    return 0
  else
    return 1
  fi
}

missing() {
    echo -e "${RED}$1 is missing."
    echo
    exit 1
}

read_var() {
    VAR=$(grep $1 $2 | xargs)
    IFS="=" read -ra VAR <<< "$VAR"
    echo ${VAR[1]}
}

url_exists() {
    if curl --head --silent --fail "$1" 2> /dev/null;
      then
        return 0
      else
        return 1
    fi
}
