#!/bin/bash

# Fast fail the script on failures.
set -e

(cd ..; git clone https://github.com/flutter/flutter.git -b alpha; cd flutter; ./bin/flutter doctor)
