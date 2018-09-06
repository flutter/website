#!/usr/bin/env bash
#
# Tweaked a copy of https://github.com/dart-lang/site-shared/blob/master/tool/serve.sh

set -e -o pipefail

[[ -z "$DART_SITE_ENV_DEFS" ]] && . ./tool/env-set.sh

PORT=${SITE_LOCALHOST_PORT:-4002}

set +e
SITE=$(grep '^destination:' _config.yml | awk '{ print $2}')
set -e
: ${SITE:-_site}

if [ ! -e "./$SITE" ]; then
  echo "INFO: $SITE directory not found. Site not built? Skipping link checks."
  exit 0
fi

set -x
npx superstatic --port $PORT 2>&1 | tee > "$TMP/superstatic-log.txt" &
set +x
SERVER_PID=$!
sleep 2
if [[ -n "$TRAVIS" ]]; then sleep 2; fi

if ! kill -0 $SERVER_PID > /dev/null 2>&1; then
  echo; echo "WARNING: Failed to launch superstatic server. I'll assume it is already running."
  if [[ -n "$TRAVIS" ]]; then
    echo "Here's the report error (that we're ignoring):"; echo
    cat "$TMP/superstatic-log.txt"
  fi
  echo
  SERVER_PID=
else
  echo "Server PID: $SERVER_PID"
fi

# Don't check for external links yet since it seems to cause problems on Travis: --external
set -x
pub run linkcheck \
  --skip-file ./tool/config/linkcheck-skip-list.txt \
  :$PORT \
    | tee "$TMP/linkcheck-log.txt"
set +x

if ! grep '^\s*0 errors' "$TMP/linkcheck-log.txt" | wc -l > /dev/null; then
  CHECK_EXIT_CODE=1
  echo; cat "$TMP/superstatic-log.txt"; echo
else
  CHECK_EXIT_CODE=0
fi

if [[ -n $SERVER_PID ]]; then kill $SERVER_PID; fi

exit $CHECK_EXIT_CODE
