#!/usr/bin/env bash
# Check for non-200 links in built Jekyll site using Firebase emulator
set -eu -o pipefail 
trap clean_up EXIT # SIGINT SIGTERM ERR EXIT

EMULATOR_PORT=5500 # airplay runs on :5000

clean_up() {
  exit_value=$?
  echo "Shutting down emulator..."
  lsof -t -i:$EMULATOR_PORT | xargs kill -9 > /dev/null 2>&1
  echo "Exit code is $exit_value"
  echo $'Done!\n'

  # Linkcheck returns status 1 if there are warnings
  if [[ $exit_value -gt 1 ]]; then
    echo "Exiting with errors"
    exit $exit_value
  else
    exit 0
  fi
}

# Eliminate clutter
dart --disable-analytics

echo "Starting Firebase emulator async..."
npx firebase emulators:start \
  --only hosting \
  --project default > /dev/null 2>&1 &
emulator_status=$?

sleep 3 # wait a few just in case

if [[ -z "$emulator_status" ]]; then
  echo "Emulator did not start!"
  exit 3 # Higher than 2 to differentiate from linkcheck
else 
  echo "Emulator is running in background"
fi

SKIP_FILE="./tool/config/linkcheck-skip-list.txt"

# Will naturally print all output to stdout for visibility
dart run linkcheck :$EMULATOR_PORT --skip-file $SKIP_FILE
