#!/bin/bash

# Fast fail the script on failures.
set -e

[[ -z "$DART_SITE_ENV_DEFS" ]] && . ./tool/env-set.sh

if [[ "$1" == --force ]]; then FORCE=1; fi

# if [[ -n "$TRAVIS" ]]; then
#   ./tool/env-info-and-check.sh
# fi

FLUTTER_ROOT=../flutter
FLUTTER_BIN="$FLUTTER_ROOT/bin"
# Run doctor to download the Dart SDK that is vendored with Flutter
if [[ ! -e "$FLUTTER_ROOT" || -n "$FORCE" ]]; then
  echo "Downloading Flutter"
  (
    set -x;
    git clone -b beta https://github.com/flutter/flutter.git "$FLUTTER_ROOT";
    "$FLUTTER_BIN/flutter" doctor
  )
else
  echo "Flutter already installed: $FLUTTER_ROOT"
fi

# Don't download oauth tool since we don't currently use it.
# echo "Download Google OAuth Tool"
# pip install --user google-oauth2l --upgrade

# Jekyll needs Ruby and the Ruby bundler
travis_fold start before_install.ruby_bundler
  if [[ -n "$TRAVIS" || -n "$FORCE" || -z "$(type -t bundler)" ]]; then
    (set -x; gem install bundler)
  else
    echo "Bundler already installed. Use --force to reinstall/update."
  fi
travis_fold end before_install.ruby_bundler

# ./tool/install-dart-sdk.sh

travis_fold start before_install.pub
  pub get
travis_fold end before_install.pub
