#!/bin/bash

# Fast fail the script on failures.
set -e

echo "Extract Dart snippets from the markdown documentation."
dart tool/extract.dart

echo "Analyzing the extracted Dart libraries."

pub global activate tuneup
pub global run tuneup check

echo "Install jekyll."
gem install bundler
bundle install

echo "Building site."
bundle exec jekyll build -d build

echo "Deploying to Firebase."

npm install -g firebase-tools
firebase deploy --token "$FIREBASE_TOKEN"

