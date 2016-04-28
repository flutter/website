#!/bin/bash

# Fast fail the script on failures.
set -e

# Use the version of Dart SDK from the Flutter repository instead of whatever
# version is in the PATH.
export PATH="`pwd`/../flutter/bin/cache/dart-sdk/bin:$PATH"

echo "Using Dart version:"
dart --version

echo "Extract Dart snippets from the markdown documentation."
dart tool/extract.dart

echo "Analyzing the extracted Dart libraries."

../flutter/bin/flutter analyze example/*.dart

echo "Install jekyll."
gem install bundler
bundle install

echo "Building site."
bundle exec jekyll build

# TODO: deploy to a personal staging site, based on github ID, when not
#       merging into master

if [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
  if [ "$TRAVIS_BRANCH" = "master" ]; then
    echo "Deploying to Firebase."

    npm install -g firebase-tools
    firebase deploy --token "$FIREBASE_TOKEN" -f sweltering-fire-2088
  fi
fi
