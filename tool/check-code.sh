#!/bin/bash

set -e # Fast fail the script on failures.

readonly rootDir="$(cd "$(dirname "$0")/.." && pwd)"

[[ -z "$DART_SITE_ENV_DEFS" ]] && . ./tool/env-set.sh

while [[ $# -gt 0 ]]; do
  case "$1" in
    --null-safety)  NULL_SAFETY=1; shift;;
    --clean)        (set -x; git clean -xdf ./example); shift;;
    -h|--help)      echo "Usage: $0 [--clean] [--no-test] [--filter=example-path-pattern] [--null-safety]"
                    echo "  --filter pattern   Will skip example apps whose name does not match pattern."
                    exit 0;;
    *)              echo "ERROR: Unrecognized option: $1. Use --help for details."; exit 1;;
  esac
done

errorMessage="
Error: some code excerpts need to be refreshed. You'll need to
rerun '$rootDir/tool/refresh-code-excerpts.sh' locally, and re-commit.
"

echo "::group::refresh_code_excerpts"
  (
    set -x;
    $rootDir/tool/refresh-code-excerpts.sh --keep-dart-tool
  ) || (
    printf "$errorMessage" && git diff &&
    exit 1
  )
echo "::endgroup::"

echo "::group::check_code"
  if [[ -n $NULL_SAFETY ]]; then
    ./tool/build_check_deploy.sh --no-build --no-check-links --null-safety $*
  else
    ./tool/build_check_deploy.sh --no-build --no-check-links $*
  fi
echo "::endgroup::"
