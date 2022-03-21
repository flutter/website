#!/bin/bash

# Fast fail the script on failures.
set -e

ROOT=$(pwd)
TEST=1

while [[ "$1" == -* ]]; do
  case "$1" in
    --filter)          shift; FILTER="$1"; shift;;
    --refresh|-r)      REFRESH=1; shift;;
    --null-safety|-n)  NULL_SAFETY=1; shift;;
    --no-test)         TEST=; shift;;
    --help|-h)         echo ""
                       echo "Analyze and test examples."
                       echo ""
                       echo "Usage: $(basename $0) [options]"
                       echo ""
                       echo "  -r, --refresh      Refresh code excerpts"
                       echo "  -n, --null-safety  Run null safety examples, else runs with markdown examples"
                       echo "      --filter       Filter examples by glob pattern"
                       echo "      --no-test      Don't run tests"
                       echo "  -h, --help         Print this usage information"
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
flutter --no-version-check --version


if [[ $REFRESH ]]; then
  echo "=> Refreshing code excerpts..."
  (
    set -x;
    tool/refresh-code-excerpts.sh --keep-dart-tool
  ) || (
    echo "=> ERROR: some code excerpts were not refreshed!";
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


if [[ -z $NULL_SAFETY ]]; then 
  # NOTE These snippets will never be migrated to null safety

  echo "=> Resetting packages..."
  (
    set -x;
    rm -rf example.g
    mkdir -pv example.g
    cp example/* example.g/
  )
  (cd example.g && flutter --no-version-check packages get)

  echo "=> EXTRACTING OLD example/* code snippets from the markdown..."
  dart tool/extract.dart

  echo "=> ANALYZING extracted code snippets..."
  (cd example.g && flutter --no-version-check analyze .)

  echo "=> DART FORMAT checking of extracted code snippets..."
  check_formatting example.g

else
  # Extract snippets, analyze and check formatting
  # Null safety flag set
  EXAMPLE_ROOT="examples"
  echo "=> ANALYZING and testing apps in $EXAMPLE_ROOT/* --null-safety"
  
  for sample in $EXAMPLE_ROOT/*/*{,/*}; do

    # Does it have a pubspec?
    if [[ -d "$sample" && -e "$sample/pubspec.yaml" ]]; then

      # Does it match our filter?
      if [[ -n "$FILTER" && ! $sample =~ $FILTER ]]; then
        echo "=> Example: $sample - skipped because of filter"
        continue;
      
      # Skip submodules
      elif [[ "$(cd $sample ; git rev-parse --show-superproject-working-tree)" ]]; then
        echo "=> Example: $sample - skipped because it's in a sumbodule."
        continue;

      # TODO(filiph): Fix the example and remove this special case
      elif [[ $sample =~ "intl_example" ]]; then
        echo "=> Example: $sample - skipped because it fails now"
        continue;
      
      else
        echo "=> Example: $sample"
      fi

      # Only hydrate the sample if we're going to test it.
      if [[ -n $TEST && -d "$sample/test" ]]; then
        (
          set -x;
          cd $ROOT;
          flutter create --no-overwrite --no-version-check $sample
          rm -rf $sample/integration_test # Remove unneeded integration test stubs.
        )
      fi

      (
        set -x;
        cd $sample
        flutter --no-version-check packages get;
        flutter --no-version-check analyze .;
      )

      if [[ -n $TEST && -d "$sample/test" ]]; then
        (
          cd $sample;
          set -x;
          echo "=> Running tests..."
          flutter --no-version-check test
        )
      elif [[ -n $TEST ]]; then
        echo "=> Sample has no tests"
      fi
      echo ""
    fi
  done
fi
