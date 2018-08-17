#!/usr/bin/env bash
#
# Copied from https://github.com/dart-lang/site-shared/blob/master/tool/serve.sh

set -e -o pipefail

# Assume that this script will be linked to ~/scripts/foo or ~/tool/foo in the parent repo.
cd `dirname $0`/..

SERVE=superstatic

while [[ "$1" == -* ]]; do
  case "$1" in
    --dev)        FILE=_config_dev.yml
                  if [[ -e $FILE ]]; then
                    CONFIG=",$FILE$CONFIG"
                  else
                    echo "Warning: $1 option ignored because $FILE not found"
                  fi
                  shift;;
    --pin-now)    FILE=_config_now.yml
                  if [[ -e $FILE ]]; then
                    CONFIG=",$FILE$CONFIG"
                  else
                    echo "Warning: $1 option ignored because $FILE not found"
                  fi
                  shift;;
    --firebase)   SERVE="firebase serve"; shift;;
    -h|--help)    echo "Usage: $(basename $0) [--dev|--pin-now] [--firebase] [--help]"; exit 0;;
    *)            echo "ERROR: Unrecognized option: $1. Use --help for details."; exit 1;;
  esac
done

if [[ -n $CONFIG ]]; then
  CONFIG="--config _config.yml$CONFIG"
fi

PORT=$(grep '^port:' _config.yml | awk '{ print $2}' || echo 4000)

bundle exec jekyll build $CONFIG --incremental --watch &
j_pid=$!
$SERVE --port $PORT &
f_pid=$!
echo "cached PIDs: $j_pid, $f_pid"
trap "{ kill $j_pid; kill $f_pid; exit 0;}" SIGINT
wait
