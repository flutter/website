#!/bin/bash

set -e # Fail fast

ROOT=$(pwd)
TARGET=${FLUTTER_TEST_BRANCH:-stable} # default to stable

while [[ "$1" == -* ]]; do
  case "$1" in
    --target)   shift; TARGET=$1; shift;;
    --help|-h)  echo ""
                echo "Refresh, analyze and test code examples"
                echo ""
                echo "Usage: $(basename $0) [options]";
                echo ""
                echo "      --target Flutter channel target [stable]"
                echo "  -h, --help   Print this usage information"
                echo ""
                exit 0;;
    *)          echo "Unrecognized option: $1. Use --help for usage."; exit 0;;
  esac
done

# We use different Flutter SDKs on different tasks. The flutter
# submodule has a pinned commit that will be checkout out. The checkout 
# is a shallow, single-branch (depth=1) checkout so to get to other 
# versions of flutter without doing a full checkout we need to tell 
# git about the remote branch, fetch it, and then check it out. To know
# its version, the flutter tool relies on the tags. Those need to be 
# pulled separately with a shallow fetch to avoid fetching all of them.
BETA=beta                     # Beta channel
STABLE=stable                 # Stable channel

# TODO(rearch) indentify usage of this target, whether locally when 
# testing a particular commit or on a github action deploy
SUBMODULE=submodule-commit    # Pinned flutter submodule commit

if [[ -z "$TARGET" || ! "$TARGET" =~ ^($BETA|$STABLE)$ ]]; then
  echo $'\nA valid Flutter branch target is required!\n'
  exit 0
fi

function switch_flutter_channel() {
  pushd flutter
  git remote set-branches origin $1
  git fetch --depth 1 origin $1
  git checkout $1 --
  git pull
  popd
  flutter doctor
}

echo $'\n================== Running Tests =================='

rm -rf **/*.log tmp example.g .dart_tool
current_branch=$(cd flutter && git rev-parse --abbrev-ref HEAD)

echo "=> Current branch = $current_branch, target = $TARGET"

# NOTE when fresh the submodule will always be a pull of stable
if [[ "$current_branch" != "$TARGET" ]]; then
  echo $'\n---------------------------------------------------'
  echo "=> Switching from \"$current_branch\" to \"$TARGET\" branch"
  echo $'---------------------------------------------------\n'
  switch_flutter_channel $TARGET
fi

time tool/check-code.sh --refresh

echo $'\nDone!\n'
