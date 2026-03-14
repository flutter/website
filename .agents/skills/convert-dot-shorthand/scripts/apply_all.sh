#!/bin/bash
# scripts/apply_all.sh
# Unconditionally converts all potential Shorthands.
# It is the AI Agent's job to revert bad conversions using git diff.

TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: ./apply_all.sh <target_directory>"
  exit 1
fi

echo "Applying overly-aggressive shorthands to $TARGET_DIR..."

find "$TARGET_DIR" -type f -name "*.dart" -print0 | while IFS= read -r -d '' file; do
    # Colors.black26 -> .black26
    sed -i -E 's/Colors\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # EdgeInsets.all(...) -> .all(...)
    sed -i -E 's/EdgeInsets\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # BorderRadius.* -> .*
    sed -i -E 's/BorderRadius\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # Alignment.* -> .*
    sed -i -E 's/Alignment\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # MainAxisAlignment.* -> .*
    sed -i -E 's/MainAxisAlignment\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # CrossAxisAlignment.* -> .*
    sed -i -E 's/CrossAxisAlignment\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # BoxFit.* -> .*
    sed -i -E 's/BoxFit\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # FontWeight.* -> .*
    sed -i -E 's/FontWeight\.([a-zA-Z0-9_]+)/\.\1/g' "$file"
    # Expanded -> No shorthand for widget types, but keeping here for future rules.
done

echo "Done applying regex. PLEASE RUN 'dart format' and 'git diff' to review heuristics."
