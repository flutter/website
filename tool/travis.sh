#!/bin/bash

# Fast fail the script on failures.
set -e

# Use the version of Dart SDK from the Flutter repository instead of whatever
# version is in the PATH.
export PATH="../flutter/bin/cache/dart-sdk/bin:$PATH"

echo "Path to dart is:"
which dart

echo "Using Dart version:"
dart --version

pub get

echo "Extract Dart snippets from the markdown documentation."
dart tool/extract.dart

echo "Analyzing the extracted Dart libraries."

../flutter/bin/flutter analyze example/*.dart

echo "Check formatting of the extracted Dart libraries."

FMT_RESULT=`dartfmt -n example/*.dart`
if [ "${FMT_RESULT}" = "" ]; then
  echo "No formatting errors!"
else
  echo "There are formatting errors in the following files:"
  echo "$FMT_RESULT"
  exit 1
fi

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

    npm install --global firebase-tools@3.0.0
    firebase -P sweltering-fire-2088 --token "$FIREBASE_TOKEN" deploy
  fi
fi
