#!/bin/bash

set -e # Fast fail the script on failures.

[[ -z "$DART_SITE_ENV_DEFS" ]] && . ./tool/env-set.sh

if [[ $1 == --clean ]]; then
  shift;
  (set -x; git clean -xdf ./example)
fi

if [[ $1 == --help || $1 == -h ]]; then
  echo "Usage: $0 [--clean]"
  exit 0
fi

exec ./tool/build_check_deploy.sh --no-build --no-check-links
