#!/bin/bash
#
# FIXME(chalin): this script really needs to be split into multiple scripts.

# Fast fail the script on failures.
set -e

cd `dirname $0`/..
ROOT=$(pwd)

BUILD=1
CHECK_CODE=1
CHECK_LINKS=1
PUB_CMD="get"
TEST=1

while [[ "$1" == -* ]]; do
  case "$1" in
    --filter)         shift; FILTER="$1"; shift;;
    --null-safety)    NULL_SAFETY=1; shift;;
    --no-build)       BUILD=; shift;;
    --no-check-code)  CHECK_CODE=; shift;;
    --no-check-links) CHECK_LINKS=; shift;;
    --no-get)         PUB_CMD=""; shift;;
    --no-test)        TEST=; shift;;
    --up*)            PUB_CMD="upgrade"; shift;;
    -h|--help)        echo "Usage: $(basename $0) [-h|--help] [--no-get|--upgrade] [--no-[build|check-links|test]] [--filter=project-glob-pattern] [--null-safety]";
                      exit 0;;
    *)                echo "ERROR: Unrecognized option: $1. Use --help for details."; exit 1;;
  esac
done

# Write errors to stderr
function error() {
  echo "FAIL: $@" 1>&2
}

# Checks the formatting of the Dart files to make sure it conforms to dartfmt
# output.
function check_formatting() {
  # Read files one line at a time, in case there are spaces in the names.
  local fmt_result=()
  IFS=$'\n' fmt_result=($("$dartfmt" -n "$@" 2>&1))
  local fmt_code=$?
  if [[ "$fmt_code" != 0 ]]; then
    error "dartfmt exited with the following exit code: ${fmt_code}"
    error "${fmt_result[@]}"
    exit 1
  elif [[ "${#fmt_result[@]}" == 0 ]]; then
    echo "No formatting errors!"
  else
    pushd $@
    error "There are formatting errors in the following files:"$'\n'
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

# Deploys website to Firebase, trying up to total_tries times.
function deploy() {
  local total_tries="$1"
  local remaining_tries="$total_tries"
  local project="$2"
  while [[ "$remaining_tries" > 0 ]]; do
    # FIREBASE_TOKEN is set in the .cirrus.yml file.
    npx firebase deploy --token "$FIREBASE_TOKEN" --non-interactive --project "$project" && break
    remaining_tries=$(($remaining_tries - 1))
    error "Error: Unable to deploy project $project to Firebase. Retrying in five seconds... ($remaining_tries tries left)"
    sleep 5
  done

  [[ "$remaining_tries" == 0 ]] && {
    error "Deployment still failed after $total_tries tries: '$@'"
    return 1
  }
  return 0
}

# Used to reliably find the absolute location of this script.
function script_location() {
  local script_location="${BASH_SOURCE[0]}"
  # Resolve symlinks
  while [[ -h "$script_location" ]]; do
    DIR="$(cd -P "$(dirname "$script_location")" >/dev/null && pwd)"
    script_location="$(readlink "$script_location")"
    [[ "$script_location" != /* ]] && script_location="$DIR/$script_location"
  done
  echo "$(cd -P "$(dirname "$script_location")" >/dev/null && pwd)"
}

# Set the FLUTTER_ROOT and PATH, in case we're running this script locally.
# Assumes that the flutter dir is at the same level as the website dir.
FLUTTER_ROOT="${FLUTTER_ROOT:-$(script_location)/../../flutter}"
FLUTTER_ROOT="$(cd $FLUTTER_ROOT; pwd)"
echo "Using FLUTTER_ROOT '$FLUTTER_ROOT'"

export PATH="$FLUTTER_ROOT/bin/cache/dart-sdk/bin:$FLUTTER_ROOT/bin:$PATH"

if [[ ! -x "$FLUTTER_ROOT/bin/flutter" ]]; then
  error "The FLUTTER_ROOT variable must point to your Flutter repo for this "
  error "script to run correctly. Alternatively, it can be located as a sibling"
  error "to the 'website' directory."
  error "Currently looking for FLUTTER_ROOT in '$FLUTTER_ROOT'"
  exit 1
fi

# Use the version of Dart SDK from the Flutter repository instead of whatever
# version is in the PATH. FLUTTER_ROOT comes from the Cirrus Docker image.
# This is mainly guarding against something installing Dart (e.g. as a
# dependency) in another location and somehow getting into the PATH ahead of the
# one in FLUTTER_ROOT, or against a corrupt install of the SDK. It's unlikely,
# but we want to fail to find these if it happens.
dart="$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dart"
dartfmt="$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dartfmt"
pub="$FLUTTER_ROOT/bin/cache/dart-sdk/bin/pub"
flutter="$FLUTTER_ROOT/bin/flutter"

echo "Using Dart SDK: $dart"
"$dart" --version

if [[ -n $PUB_CMD ]]; then
  (
    set -x;
    rm -rf example.g
    mkdir -pv example.g
    cp example/* example.g/
  )
  (
    cd example.g;
    "$flutter" packages $PUB_CMD
  )
fi

if [[ -n $CHECK_CODE ]]; then
  if [[ -z $NULL_SAFETY ]]; then # These snippets will never be migrated.
    echo "EXTRACTING code snippets from the markdown:"
    "$dart" tool/extract.dart

    echo "using Flutter version: $flutter"
    "$flutter" --version

    echo "ANALYZING extracted code snippets:"
    # TODO(dnfield): Remove this once CI passes without it. There appears to be
    # a bug currently in the Dart version in flutter:stable that fails to analyze
    # when these are present.
    (
      set -x;
      rm -rf .dart_tool
      rm -rf example.g/.dart_tool
    )
    (cd example.g; "$flutter" analyze .)

    echo "DARTFMT check of extracted code snippets:"
    check_formatting example.g
  fi

  case "$NULL_SAFETY" in
    1) EXAMPLE_ROOT="null_safety_examples" ;;
    *) EXAMPLE_ROOT="examples" ;;
  esac
  echo "ANALYZING and testing apps in $EXAMPLE_ROOT/*"
  for sample in $EXAMPLE_ROOT/*/*{,/*}; do
    if [[ -d "$sample" && -e "$sample/pubspec.yaml" ]]; then
      if [[ -n "$FILTER" && ! $sample =~ $FILTER ]]; then
        echo "Example: $sample - skipped because of filter"
        continue;
      elif [[ "$(cd $sample ; git rev-parse --show-superproject-working-tree)" ]]; then
        echo "Example: $sample - skipped because it's in a sumbodule."
        continue;
      elif [[ $sample =~ "intl_example" ]]; then
        # TODO(filiph): Fix the example and remove this special case
        echo "Example: $sample - skipped because it fails now"
        continue;
      else
        echo "Example: $sample"
      fi

      if [[ -n $TEST && -d "$sample/test" ]]; then
        # Only hydrate the sample if we're going to test it.
        (
          set -x;
          cd $ROOT;
          "$flutter" create --no-overwrite $sample
          rm -rf $sample/integration_test # Remove unneeded integration test stubs.
        )
      fi
      (
        set -x;
        cd "$sample"
        "$flutter" packages $PUB_CMD;
        "$flutter" analyze .;
      )
      if [[ -n $TEST && -d "$sample/test" ]]; then
        (
          cd "$sample";
          set -x;
          "$flutter" test
        )
      elif [[ -n $TEST ]]; then
        echo "Sample has no tests."
      fi
      echo
    fi
  done

else
  echo "SKIPPING: code checks"
fi

if [[ -n $BUILD ]]; then
  echo "BUILDING site:"
  bundle exec jekyll build
else
  echo "SKIPPING: site build"
fi

if [[ -n $CHECK_LINKS ]]; then
  echo "CHECKING links:"
  rake checklinks
  echo "SUCCESS: check links"
else
  echo "SKIPPING: check links"
fi

# Deploy on all non-PR master branch builds.
if [[ -z "$CIRRUS_PR" && "$CIRRUS_BRANCH" == "master" ]]; then
  echo "Deploying website to Firebase:"
  deploy 5 flutter-dev-230821
  echo "SUCCESS: Website deployed"
fi

exit 0
