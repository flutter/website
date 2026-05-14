#!/usr/bin/env bash
# Copyright 2026 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -euo pipefail

firebase_channel_for_site() {
  local site="$1"
  local branch="${HEAD_BRANCH:-${COMMIT_SHA:-manual}}"
  local channel
  channel="$(tr '[:upper:]' '[:lower:]' <<< "$site-pr${PR_NUMBER:-manual}-$branch" \
    | sed -E 's/[^a-z0-9-]+/-/g')"
  channel="${channel:0:63}"
  sed -E 's/-+$//' <<< "$channel"
}

deploy_site_to_staging() {
  local site="$1"
  local firebase_config_dir="$2"

  local channel
  channel="$(firebase_channel_for_site "$site")"

  echo "Building $site for staging..."
  dart run dash_site --site="$site" build

  echo "Deploying $site to Firebase channel $channel..."
  local deploy_output_file
  deploy_output_file="$(mktemp)"
  trap 'rm -f "$deploy_output_file"' RETURN
  (
    cd "$firebase_config_dir"
    firebase hosting:channel:deploy "$channel" --expires 7d 2>&1 |
      tee "$deploy_output_file"
  )

  local staging_url
  staging_url="$(grep -m1 -Eo 'https://[a-zA-Z0-9./?=_%:-]+--[a-zA-Z0-9./?=_%:-]*' "$deploy_output_file" || true)"

  if [[ -z "$staging_url" ]]; then
    echo "Failed to find a Firebase staging URL for $site." >&2
    return 1
  fi

  deployed_staging_url="$staging_url"
}

comment_staging_url_on_github() {
  local site="$1"
  local display_name="$2"
  local staging_url="$3"
  local comment_marker="<!-- flutter-preview-$site -->"

  local comment_body
  comment_body="$comment_marker
Preview URL for the $display_name site (updated for commit ${COMMIT_SHA:-unknown}):

$staging_url"

  echo "Commenting $display_name staging URL on the PR..."
  local comment_id
  comment_id="$(
    gh api "repos/$REPO_FULL_NAME/issues/$PR_NUMBER/comments" \
      --paginate \
      --jq ".[] | select(.body | contains(\"$comment_marker\")) | .id" |
      tail -n 1
  )"

  if [[ -n "$comment_id" ]]; then
    gh api \
      --method PATCH \
      "repos/$REPO_FULL_NAME/issues/comments/$comment_id" \
      -f "body=$comment_body" \
      > /dev/null
  else
    gh api \
      --method POST \
      "repos/$REPO_FULL_NAME/issues/$PR_NUMBER/comments" \
      -f "body=$comment_body" \
      > /dev/null
  fi
}

: "${SITE:?Set the _SITE Cloud Build substitution to 'docs' or 'www'.}"

case "$SITE" in
  docs)
    firebase_config_dir="."
    display_name="Docs"
    ;;
  www)
    firebase_config_dir="sites/www"
    display_name="Flutter.dev"
    ;;
  *)
    echo "Error: Unsupported site '$SITE'. Expected 'docs' or 'www'." >&2
    exit 1
    ;;
esac

if [[ -n "${PR_NUMBER:-}" && -n "${REPO_FULL_NAME:-}" ]]; then
  echo "Logging into GitHub under bot account..."
  printf '%s\n' "$GH_PAT_TOKEN" | gh auth login --with-token
fi

echo "Fetching Dart dependencies..."
dart pub get

deployed_staging_url=""
deploy_site_to_staging "$SITE" "$firebase_config_dir"

if [[ -z "${PR_NUMBER:-}" || -z "${REPO_FULL_NAME:-}" ]]; then
  echo "No pull request context available; skipping GitHub comment."
  exit 0
fi

comment_staging_url_on_github "$SITE" "$display_name" "$deployed_staging_url"
