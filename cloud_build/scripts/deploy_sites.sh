#!/usr/bin/env bash
# Copyright 2026 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -euo pipefail

deploy_site() {
  local site="$1"
  local firebase_config_dir="$2"

  echo "Building $site for production..."
  dart run dash_site --site="$site" build --release

  echo "Deploying $site..."
  (
    cd "$firebase_config_dir"
    firebase deploy --only=hosting
  )
}

: "${SITE:?Set the _SITE Cloud Build substitution to 'docs' or 'www'.}"

echo "Fetching Dart dependencies..."
dart pub get

case "$SITE" in
  docs)
    deploy_site docs .
    ;;
  www)
    deploy_site www sites/www
    ;;
  *)
    echo "Error: Unsupported site '$SITE'. Expected 'docs' or 'www'." >&2
    exit 1
    ;;
esac
