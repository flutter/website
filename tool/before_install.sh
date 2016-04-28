#!/bin/bash

# Fast fail the script on failures.
set -e

echo "Downloading Flutter"

# Run doctor to download the Dart SDK that is vendored with Flutter

(cd ..; git clone https://github.com/flutter/flutter.git -b alpha ; cd flutter ; flutter doctor)
