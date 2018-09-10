#!/usr/bin/env bash

FLUTTER_ROOT=flutter
FLUTTER_BIN="$FLUTTER_ROOT/bin"

if [[ ! -e "$FLUTTER_ROOT" ]]; then
  echo "ERROR: The ~/flutter git submodule is missing. For initialization instructions, see the repo README."
  exit 1;
fi

source tool/shared/before-install.sh

travis_fold start before_install.flutter
echo "Refreshing Flutter repo and running doctor:"
(
  set -x;
  cd flutter;
  git checkout beta;
  git pull;
  bin/flutter doctor;
)
travis_fold end before_install.flutter
