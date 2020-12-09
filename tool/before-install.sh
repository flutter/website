#!/usr/bin/env bash

source tool/shared/before-install.sh

# Site-specific settings below this point.

travis_fold start before_install.flutter
echo "Refreshing Flutter repo and running doctor:"
(
  set -x;
  cd flutter;
  git checkout stable;
  git pull;
  bin/flutter doctor;
)
travis_fold end before_install.flutter
