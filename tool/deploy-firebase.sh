#!/usr/bin/env bash

FB_PROJ=$1
: ${FB_PROJ:=default}

echo "================ Deploy to Firebase ($FB_PROJ) ========================"
firebase deploy --non-interactive --token "$FIREBASE_TOKEN" --project $FB_PROJ
