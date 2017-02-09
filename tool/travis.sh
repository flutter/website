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

../flutter/bin/flutter packages get

# Analyze the stand-alone sample code files

for D in _includes/_code/*; do
  if [ -d "${D}" ]; then
    echo "Run flutter packages get on ${D}"
    flutter packages get ${D}

    echo "Run flutter analyze on ${D}"
    flutter analyze ${D}/*.dart
  fi
done

echo "Extract Dart snippets from the markdown documentation."
dart tool/extract.dart

echo "Analyzing the extracted Dart libraries."

../flutter/bin/flutter analyze example/*.dart

echo "Check formatting of the extracted Dart libraries."

FMT_RESULT=`dartfmt -n example/*.dart 2>&1`
FMT_CODE=$?
if [ $FMT_CODE -ne 0 ]; then
  echo "dartfmt exits with the following exit code: ${FMT_CODE}"
  echo "${FMT_RESULT}"
  exit 1
elif [ "${FMT_RESULT}" = "" ]; then
  echo "No formatting errors!"
else
  echo "There are formatting errors in the following files:"
  echo ""
  for FILE in $FMT_RESULT; do
    echo "===== $FILE ====="
    cp "$FILE"{,.expected}
    dartfmt -w "$FILE.expected" &> /dev/null
    echo "----- expected format -----"
    cat "$FILE.expected"
    echo "----- current format -----"
    cat "$FILE"
    echo "----- diff -----"
    echo "`diff "$FILE.expected" "$FILE"`"
    echo "===== /end $FILE ====="
    rm "$FILE.expected"
    echo ""
  done
  exit 1
fi

echo "Install jekyll."
gem install bundler
bundle install

echo "Building site."
bundle exec jekyll build

echo "Validating all links."
bundle exec htmlproofer _site --empty-alt-ignore --url-ignore "#" --only-4xx

if [ "$TRAVIS_EVENT_TYPE" = "push" ] && [ "$TRAVIS_BRANCH" = "master" ]; then
  # Deploy pushes to master to Firebase hosting.
  # TODO: deploy to a personal staging site, based on github ID, when not
  #       merging into master
  echo "Deploying to Firebase."
  npm install --global firebase-tools@3.0.0
  firebase -P sweltering-fire-2088 --token "$FIREBASE_TOKEN" deploy
fi
