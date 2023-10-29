#!/bin/bash

# Fast fail the script on failures.
set -e

ROOT=$(pwd)
TEST=1

while [[ "$1" == -* ]]; do
  case "$1" in
    --filter)          shift; FILTER="$1"; shift;;
    --refresh|-r)      REFRESH=1; shift;;
    --no-test)         TEST=; shift;;
    --help|-h)         echo ""
                       echo "Analyze and test examples."
                       echo ""
                       echo "Usage: $(basename $0) [options]"
                       echo ""
                       echo "  -r, --refresh  Refresh code excerpts"
                       echo "      --filter   Filter examples by glob pattern"
                       echo "      --no-test  Don't run tests"
                       echo "  -h, --help     Print this usage information"
                       echo "";
                       exit 0;;
    *)                 echo "Unrecognized option: $1. Use --help for usage."; exit 0;;
  esac
done


# Write errors to stderr
function error() {
  echo $'\n'"ERROR: $@" 1>&2
}


echo "=> Using Dart version:"
dart --version

echo "=> Using Flutter version:"
flutter --version

if [[ $REFRESH ]]; then
  echo "=> Refreshing code excerpts..."
  (
    commitHash=$(git reflog -n1 --format='%h')
    git add .
    git commit -m "Temporarily commit code excerpt changes"
    set -x
    tool/refresh-code-excerpts.sh --keep-dart-tool
    git reset --soft $commitHash
  ) || (
    git --no-pager diff
    echo "=> ERROR: some code excerpts were not refreshed!"
    exit 1
  )
fi


function check_formatting() {
  # Read files one line at a time, in case there are spaces in the names.
  local fmt_result=()
  IFS=$'\n' fmt_result=($(dart format "$@" 2>&1))
  local fmt_code=$?

  if [[ "$fmt_code" != 0 ]]; then
    error "=> dart format exited with the following exit code: $fmt_code"
    error "${fmt_result[@]}"
    exit 1
  elif [[ "$fmt_code" == 0 ]]; then
    echo "=> No formatting errors!"
  else
    pushd $@
    error "=> There are formatting errors in the following files:"$'\n'
    for file in "${fmt_result[@]}"; do
      error "===== $file ====="
      cp "$file" "$file.expected"
      "$dartfmt" -w "$file.expected" &> /dev/null
      error "----- expected format -----"
      cat "$file.expected" 1>&2
      error "----- current format -----"
      cat "$file" 1>&2
      error "----- diff -----"
      diff "$file.expected" "$file" 1>&2
      error "===== /end $file ====="$'\n'
      rm "$file.expected"
    done
    popd
    return 1
  fi
}

# Extract snippets, analyze, and check formatting.
EXAMPLE_ROOT="examples"
echo "=> ANALYZING and testing apps in $EXAMPLE_ROOT/*"

# Find all pubspec.yaml files within /examples that are not in the
# codelabs directory codelabs or a hidden directory.
# Then loop through each one, get their directory,
# and run analysis and tests on each one.
find $EXAMPLE_ROOT -not \( -type d -path "*/.*" -prune \) \
  -not \( -type d -path "$EXAMPLE_ROOT/codelabs" -prune \) \
  -type f -name "pubspec.yaml" | sort | while read -r PUBSPEC_FILE; do
  sample=$(dirname "$PUBSPEC_FILE")

  # Does it match our filter?
  if [[ -n "$FILTER" && ! $sample =~ $FILTER ]]; then
    echo "=> Example: $sample - skipped because of filter"
    continue

  else
    echo "=> Example: $sample"
  fi

  (
    set -x
    cd $sample
    flutter pub get > /dev/null # Get dependencies, but ignore stdout.
    flutter analyze .
  )

  if [[ -n $TEST && -d "$sample/test" ]]; then
    (
      cd $sample
      set -x
      echo "=> Running tests..."
      flutter test -r expanded
    )
  elif [[ -n $TEST ]]; then
    echo "=> Sample has no tests"
  fi
  echo ""
done
