#!/bin/bash

# Fast fail the script on failures.
set -e

echo "Downloading Flutter"

# Update to the latest beta, in case the docker image is out of date.

(cd "$FLUTTER_ROOT"; ./bin/flutter upgrade; ./bin/flutter doctor)

