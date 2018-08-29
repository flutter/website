#!/bin/bash

set -e # Fast fail the script on failures.

exec ./tool/build_check_deploy.sh --no-build --no-check-links
