#!/bin/bash

set -e # Fast fail the script on failures.

[[ -z "$DART_SITE_ENV_DEFS" ]] && . ./tool/env-set.sh

exec ./tool/build_check_deploy.sh --no-build --no-check-links
