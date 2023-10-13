#!/bin/bash

set -e # Fail fast

echo $'\n================== Running Tests =================='

rm -rf **/*.log tmp example.g .dart_tool

time tool/check-code.sh --refresh

echo $'\nDone!\n'
