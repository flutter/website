#!/usr/bin/env bash
#
# Copied from https://github.com/dart-lang/site-shared/blob/master/tool/serve.sh

set -e -o pipefail

# Assume that this script will be linked to ~/scripts/foo or ~/tool/foo in the parent repo.
cd `dirname $0`/..

if [[ "$1" == "--dev" && -e _config_dev.yml ]]; then
  shift;
  CONFIG=",_config_dev.yml$CONFIG"
fi

if [[ "$1" == "--pin-now" && -e _config_now.yml ]]; then
  shift;
  CONFIG=",_config_now.yml$CONFIG"
fi

if [[ -n $CONFIG ]]; then
  CONFIG="--config _config.yml$CONFIG"
fi

PORT=$(grep '^port:' _config.yml | awk '{ print $2}' || echo 4000)

bundle exec jekyll build $CONFIG --incremental --watch &
j_pid=$!
superstatic --port $PORT &
f_pid=$!
echo "cached PIDs: $j_pid, $f_pid"
trap "{ kill $j_pid; kill $f_pid; exit 0;}" SIGINT
wait
