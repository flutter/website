#!/bin/bash

# Fast fail the script on failures.
set -e

# Use the version of Dart SDK from the Flutter repository instead of whatever
# version is in the PATH.
export PATH="`pwd`/../flutter/bin/cache/dart-sdk/bin:$PATH"

(cd ..; git clone https://github.com/flutter/flutter.git -b alpha; cd flutter; ./bin/flutter doctor ; pub get)
