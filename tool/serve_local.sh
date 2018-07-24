#!/usr/bin/env bash

set -e -o pipefail

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

bundle exec jekyll build $CONFIG --incremental --watch &
j_pid=$!
superstatic --port 4002 &
f_pid=$!
echo "cached PIDs: $j_pid, $f_pid"
trap "{ kill $j_pid; kill $f_pid; exit 0;}" SIGINT
wait
