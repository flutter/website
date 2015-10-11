#!/bin/bash

# Fast fail the script on failures.
set -e

# Extract Dart snippets from the markdown documentation.
dart tool/extract.dart

# Analyze the extracted Dart libraries.
pub global activate tuneup
pub global run tuneup check
