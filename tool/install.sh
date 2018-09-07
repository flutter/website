#!/usr/bin/env bash

set -e -o pipefail

[[ -z "$DART_SITE_ENV_DEFS" ]] && . ./tool/env-set.sh

cd `dirname $0`/..

if [[ "$(node --version)" < "v10" ]]; then
    echo "ERROR: bad version of node detected. If you have nvm installed, type:"
    echo "  nvm use"
    echo "Aborting installation."
    exit 1;
else
    echo "Node version: $(node --version)"
fi

if ! __type_t travis_fold; then travis_fold() { true; } fi # For ZSH users

travis_fold start install.npm_install
  (set -x; npm install --no-optional)
travis_fold end install.npm_install

if [[ -z "$TRAVIS" || "$TASK" == *build* ]]; then
  travis_fold start install.bundle
    (set -x; bundle install)
  travis_fold end install.bundle
fi

echo "Installation done"
