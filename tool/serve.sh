#!/usr/bin/env bash
#
# Tweaked a copy of https://github.com/dart-lang/site-shared/blob/master/tool/serve.sh

set -e -o pipefail

# Assume that this script will be linked to ~/scripts/foo or ~/tool/foo in the parent repo.
cd `dirname $0`/..

SERVE="npx superstatic"
JEKYLL_OPTS="--incremental --watch "

while [[ "$1" == -* ]]; do
  case "$1" in
    --clean)    CLEAN=1; shift;;
    --dev)      FILE=_config_dev.yml
                if [[ -e $FILE ]]; then
                  CONFIG=",$FILE$CONFIG"
                else
                  echo "Warning: $1 option ignored because $FILE not found"
                fi
                shift;;
    --firebase) SERVE="npx firebase serve";
                shift;;
    -h|--help)  echo "Usage: $(basename $0) [options]";
                echo
                echo "  --clean     Delete the content of site.g before building the site."
                echo "  --dev       Build using _config_dev.yml."
                echo "  --firebase  Serve using firebase rather than superstatic."
                echo "  --help      Print this usage text."
                echo "  --pin-now   Build using _config_now.yml."
                echo "  --trace     Run jekyll build with --trace."
                exit 0;;
    --pin-now)  FILE=_config_now.yml
                if [[ -e $FILE ]]; then
                  CONFIG=",$FILE$CONFIG"
                else
                  echo "Warning: $1 option ignored because $FILE not found"
                fi
                shift;;
    --trace)    JEKYLL_OPTS+="--trace ";
                shift;;
    *)          echo "ERROR: Unrecognized option: $1. Use --help for details.";
                exit 1;;
  esac
done

if [[ -n $CONFIG ]]; then
  CONFIG="--config _config.yml$CONFIG"
fi

set +e
DEST=$(grep '^destination:' _config.yml | awk '{ print $2}')
set -e
SITE_PATH="./${DEST:-_site}"
if [[ -n $CLEAN ]]; then
  if [[ -e "$SITE_PATH" ]]; then
    (set -x; rm -Rf "$SITE_PATH/*")
  else
    echo "WARNING: $SITE_PATH doesn't exist, so there is nothing to clean."; echo
  fi
fi

(set -x; bundle exec jekyll build $CONFIG $JEKYLL_OPTS) &
j_pid=$!
(set -x; $SERVE --version; $SERVE --port ${SITE_LOCALHOST_PORT:-4002}) &
f_pid=$!
echo "Cached PIDs for build and serve: $j_pid, $f_pid"
trap "{ kill $j_pid; kill $f_pid; exit 0;}" SIGINT
wait
