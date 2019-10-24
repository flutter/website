#!/bin/bash

set -e # Fast fail the script on failures.

readonly rootDir="$(cd "$(dirname "$0")/.." && pwd)"

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

errorMessage="
Error: some code excerpts need to be refreshed. You'll need to
rerun '$rootDir/tool/refresh-code-excerpts.sh' locally, and re-commit.
"

travis_fold start refresh_code_excerpts
  (
    set -x;
    $rootDir/tool/refresh-code-excerpts.sh --keep-dart-tool
  ) || (
    printf "$errorMessage" && git diff &&
    exit 1
  )
travis_fold end refresh_code_excerpts

travis_fold start check_code
  ./tool/build_check_deploy.sh --no-build --no-check-links $*
travis_fold end check_code
