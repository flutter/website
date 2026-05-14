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

  preview_rows+="| $site | $staging_url |"$'\n'
}

if [[ -n "${PR_NUMBER:-}" && -n "${REPO_FULL_NAME:-}" ]]; then
  echo "Logging into GitHub under bot account..."
  printf '%s\n' "$GH_PAT_TOKEN" | gh auth login --with-token
fi

echo "Fetching Dart dependencies..."
dart pub get

preview_rows=""

deploy_site_to_staging docs .
deploy_site_to_staging www sites/www

comment_body="Preview URLs for this PR (updated for commit ${COMMIT_SHA:-unknown}):

| Site | Preview |
| --- | --- |
$preview_rows"

if [[ -z "${PR_NUMBER:-}" || -z "${REPO_FULL_NAME:-}" ]]; then
  echo "No pull request context available; skipping GitHub comment."
  exit 0
fi

echo "Commenting staging URLs on the PR..."

# If the bot already commented, edit it, otherwise leave a new comment.
gh pr comment "$PR_NUMBER" --repo "$REPO_FULL_NAME" --edit-last --body "$comment_body" \
  || gh pr comment "$PR_NUMBER" --repo "$REPO_FULL_NAME" --body "$comment_body"
