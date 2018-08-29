#!/bin/bash

set -e # Fast fail the script on failures.

source ./tool/build_check_deploy.sh

# Normalize Branch variable
export BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)

# if [ "$TRAVIS_EVENT_TYPE" == "push" ] && [ "$TRAVIS_BRANCH" == "master" ]; then
#   echo "Deploying to Firebase."
#   ! type -t firebase && npm install --global firebase-tools@4.0.3
#   firebase -P sweltering-fire-2088 --token "$FIREBASE_TOKEN" --non-interactive deploy
# fi

# Temporarily disable deploy to staging server
# if [ "$ENABLE_PR_BOT" = "true" ]; then
#     if [ "$BRANCH" != "master" ]; then
#         echo "deploying to stage environment"
#         echo $FIREBASE_FILE >> ./service_account.json
#         export FIREBASE_AUTH=`oauth2l fetch --json ./service_account.json firebase.database userinfo.email 2>&1`
#         cd tool/
#         ../../flutter/bin/cache/dart-sdk/bin/pub get
#         export PROJECT_NAME=`../../flutter/bin/cache/dart-sdk/bin/dart prdeployer.dart $BRANCH $FIREBASE_AUTH 2>&1`
#         cd ../
#         echo "Deploying to $PROJECT_NAME"
#         npm install --global firebase-tools@3.19.3
#         firebase -P "$PROJECT_NAME" --token "$FIREBASE_TOKEN_DEV" --non-interactive deploy
#     fi
# fi
