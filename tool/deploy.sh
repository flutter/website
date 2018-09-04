#!/usr/bin/env bash

if [ ! $(type -t travis_fold) ]; then travis_fold () { true; } fi

function _installFBT() {
  _PKG="firebase-tools@4.0.3"
  if ! type -t firebase > /dev/null; then
    travis_fold start deploy.firebase-tools-install
    (set -x; npm install --global $_PKG)
    travis_fold end deploy.firebase-tools-install
  fi
}

function _error() { echo "ERROR: $1"; exit 1; }

function _usage() {
  echo "Usage: $(basename $0) [--help] [--install] [--local] [--quiet] [firebase-project-name]";
  echo
  echo "  If unspecified, default firebase project is 'default'."
  echo
  echo "  --install  Does a global npm install of firebase-tools if necessary."
  echo "  --local    Deploy locally from an interactive shell where you are"
  echo "             already authenticated and logged in with firebase."
  echo
  exit 0
}

while [[ "$1" == -* ]]; do
  case "$1" in
    -h|--help)     _usage;;
    -i|--install)  _installFBT; shift;;
    -l|--local)    LOCAL=1; shift;;
    -q|--quiet)    QUIET=1; shift;;
    *)             _error echo "Unrecognized option: $1. Use --help for details.";;
  esac
done

_ARGS=""
_FB_PROJ=${1:-default}

if [[ -z $LOCAL && -z "$FIREBASE_TOKEN" ]]; then
  _error "Cannot deploy, the FIREBASE_TOKEN environment variable isn't defined."
elif [[ -z $LOCAL ]]; then
  _ARGS+=" --non-interactive --token $FIREBASE_TOKEN"
fi

_ARGS+=" --project $_FB_PROJ"

if [[ -z $QUIET ]]; then
  echo "Deploying to Firebase project: $_FB_PROJ"
  set -x # Travis masks out secrets from logs so enabling command echo is safe.
fi
firebase deploy $_ARGS
