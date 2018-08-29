#!/bin/bash

# Fast fail the script on failures.
set -e

echo "Downloading Flutter"
# Run doctor to download the Dart SDK that is vendored with Flutter
(cd ..; git clone -b beta https://github.com/flutter/flutter.git ; cd flutter ; ./bin/flutter doctor)

# Don't download oauth tool since we don't currentl use it.
# echo "Download Google OAuth Tool"
# pip install --user google-oauth2l --upgrade

if [[ -z "$TASK" || "$TASK" == *jekyll* || "$TASK" == *rake* ]]; then
  echo "Install bundler and gems"
  gem install bundler
  bundle install
else
  echo "SKIPPING 'Install bundler and gems' since this isn't a jekyll build task"
fi
