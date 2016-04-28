#!/bin/bash

# Fast fail the script on failures.
set -e

echo "Downloading Flutter"

(cd ..; git clone https://github.com/flutter/flutter.git -b alpha)
