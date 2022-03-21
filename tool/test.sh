#!/bin/bash

set -e # Fail fast


ROOT=$(pwd)
TARGET=stable  # default to stable
BUILD=1        # always test build


while [[ "$1" == -* ]]; do
  case "$1" in
    --target)       shift; TARGET=$1; shift;;
    --null-safety)  NULL_SAFETY=1; shift;;
    --no-build)     BUILD=; shift;;
    --check-links)  CHECK_LINKS=1; shift;;
    --help|-h)      echo ""
                    echo "Refresh, analyze and test code examples. Build the site and check links."
                    echo ""
                    echo "Usage: $(basename $0) [options]";
                    echo ""
                    echo "      --target       Flutter channel target [stable]"
                    echo "      --null-safety  Check null-safety code"
                    echo "      --no-build     Don't run build"
                    echo "      --check-links  Check all build links"
                    echo "  -h, --help         Print this usage information"
                    echo ""
                    exit 0;;
    *)              echo "Unrecognized option: $1. Use --help for usage."; exit 0;;
  esac
done


if [[ -n "$DISABLE_TESTS" ]]; then
  echo "=> Tests disabled by DISABLE_TESTS=$DISABLE_TESTS"
  exit 0;
fi

if [[ -z "$TARGET" ]]; then
  echo "=> A flutter branch target is required!"
  exit 0
fi

# We use different Flutter SDKs on different tasks. The flutter
# submodule has a pinned commit that will be checkout out. The checkout 
# is a shallow, single-branch (depth=1) checkout so to get to other 
# versions of flutter without doing a full checkout we need to tell 
# git about the remote branch, fetch it, and then check it out. To know
# its version, the flutter tool relies on the tags. Those need to be 
# pulled separately with a shallow fetch to avoid fetching all of them.
DEV=dev                       # Dev channel
BETA=beta                     # Beta channel
STABLE=stable                 # Stable channel

# TODO(rearch) indentify usage of this target, whether locally when 
# testing a particular commit or on a github action deploy
SUBMODULE=submodule-commit    # Pinned flutter submodule commit


function switch_flutter_channel() {
  pushd flutter
  git remote set-branches origin $1
  git fetch --depth 1 origin $1
  git checkout $1 --
  git pull
  popd
  flutter --no-version-check doctor
}


if [[ "$TARGET" =~ ^($DEV|$BETA|$STABLE)$ ]]; then

  echo $'\n================== Running Tests =================='

  rm -rf _site .jekyll* src/.jekyll* *.log tmp example.g .dart_tool
  current_branch=$(cd flutter && git rev-parse --abbrev-ref HEAD)

  # NOTE when fresh, submodule will always be a pull of stable
  if [[ "$current_branch" != "$TARGET" ]]; then
    echo $'\n---------------------------------------------------'
    echo "=> Switching to \"$TARGET\" branch";
    echo $'---------------------------------------------------\n'
    switch_flutter_channel $TARGET
  fi

  if [[ $NULL_SAFETY ]]; then
    echo $'\n---------------------------------------------------'
    echo "=> Checking null-safety examples for branch: \"$TARGET\"";
    echo $'---------------------------------------------------\n'
    tool/check-code.sh --refresh --null-safety
  fi

  if [[ $BUILD ]]; then
    echo $'\n---------------------------------------------------'
    echo "=> Build the site for branch: \"$TARGET\"";
    echo $'---------------------------------------------------\n'
    bundle exec jekyll build --config _config.yml
  fi

  # TODO superstatic in docker is broken. Until we move away from 
  # that method of link checking, this will remain commented out :)
  if [[ $CHECK_LINKS ]]; then
    echo $'\n---------------------------------------------------'
    echo "=> Checking links for build..."
    echo $'---------------------------------------------------\n'
    tool/check-links.sh
  fi

else
  echo "=> Target branch \"$TARGET\" is invalid!"
  exit 0;
fi

echo $'\nDone!\n'
