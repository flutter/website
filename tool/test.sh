#!/bin/bash

set -e # Fail fast

echo $'\n================== Running Tests =================='

rm -rf **/*.log tmp example.g .dart_tool

dart run flutter_site check-all

echo $'\nDone!\n'
