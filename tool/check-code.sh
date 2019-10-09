#!/bin/bash

set -e # Fast fail the script on failures.

[[ -z "$DART_SITE_ENV_DEFS" ]] && . ./tool/env-set.sh

if [[ $1 == --clean ]]; then
  shift;
  (set -x; git clean -xdf ./example)
fi

if [[ $1 == --help || $1 == -h ]]; then
  echo "Usage: $0 [--clean] [--no-test] [--filter=example-path-pattern]"
  echo "  --filter pattern   Will skip example apps whose name does not match pattern."
  exit 0
fi

exec ./tool/build_check_deploy.sh --no-build --no-check-links $*
