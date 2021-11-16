#!/bin/bash

set -o pipefail # Don't use -e since _cleanup can then cause the script to terminate prematurely.


export $(cat shared.env | sed 's/#.*//g' | xargs)


SERVE_PORT=${SITE_PORT:-4002}
SERVE_TARGET="_site"
ARGS=""


while [[ "$1" == -* ]]; do
  case "$1" in
    --port)             shift; PORT=$1; shift;;
    --debug|-d)         ARGS+="$1 "; shift;;
    --external|-e)      ARGS+="$1 --connection-failures-as-warnings "; EXTERNAL=1; shift;;
    --fail-on-warnings) FAILWARN=1; shift;;
    --help|-h)          echo ""
                        echo "Check that all site links ware working."
                        echo ""
                        echo "Usage: $(basename $0) [options]"
                        echo ""
                        echo "      --port              Override the server port [$SERVE_PORT]"
                        echo "  -d, --debug             Run link checker in debug"
                        echo "  -e, --external          Also check external links"
                        echo "      --fail-on-warnings  Fail if dart link checker reports warnings"
                        echo "  -h, --help              Print this usage information"
                        echo ""
                        exit 0;;
    *)                  echo "Unrecognized option: $1. Use --help for usage."; exit 1;;
  esac
done


if [ ! -e "$SERVE_TARGET" ]; then
  echo "=> Build folder not found! Is the site built?"
  exit 0
fi


# NOTE as noted in the Dockerfile, an enhancement here might be to 
# have an actual robots.txt.production template for better clarity, 
# and replacing the dev/staging robots.txt at test/build time. 
function unleash_robots() {
  echo "=> Create production version of robots.txt..."
  echo -e "User-agent: *\nAllow: /" > src/robots.txt
}

function cage_robots() {
  # NOTE legacy method, but having both of these might be 
  # redundant as the second * disallows all robots.
  echo -e "User-agent: linkcheck \nDisallow:" > src/robots.txt
  echo -e "\nUser-agent: *\nDisallow: /" >> src/robots.txt
}

function cleanup() {
  echo "=> Cleaning up..."
  cage_robots
  if [[ -z "$SERVER_PID" ]]; then
    echo "=> No server process ID was registered"
  elif [ kill -0 $SERVER_PID > /dev/null 2>&1 ]; then
    CMD="kill -9 $SERVER_PID"
    echo "=> $CMD (server process)"
    $CMD;
  else
    echo "=> Server process already stopped"
  fi
}


trap "echo; echo 'Signal trapped.'; cleanup" SIGINT SIGTERM
trap "cleanup" EXIT # original exit code is preserved


unleash_robots

node -e "console.log(require('superstatic').RE2mode())"

# Attempt to launch the server.
CMD="npx superstatic --port $SERVE_PORT"
echo "=> $CMD"
$CMD > "./linkcheck-server.log" 2>&1 &
SERVER_PID=$!
echo "=> Server PID: $SERVER_PID"

sleep 10

if [ ! kill -0 $SERVER_PID > /dev/null 2>&1 ]; then
  echo $'\nWARNING: Server command failed, server may already running.\n'
  SERVER_PID=
fi

# Don't check for external links 
CMD="dart run linkcheck $ARGS--skip-file ./tool/config/linkcheck-skip-list.txt :$SERVE_PORT"
echo "=> $CMD"
$CMD 2>&1 | tee "linkcheck-server.log"
STATUS=$?

# When checking external links, give linkcheck 
# some time to finish dumping its report
if [[ "$EXTERNAL" ]]; then
  sleep 5;
fi

echo "=> dart run linkcheck status: $STATUS"

# If not set, ignore status
if [[ $FAILWARN ]]; then
  echo "=> Exiting with status: $STATUS"
  exit $STATUS
else
  grep -qe '^\s*0 errors' "linkcheck-server.log"
fi
