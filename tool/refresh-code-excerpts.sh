#!/bin/bash

set -e -o pipefail


ROOT=$(pwd)
TMP="$ROOT/tmp"
FRAG="$TMP/_fragments"
SRC="$ROOT/src"
ARGS=""


while [[ "$1" == -* ]]; do
  case "$1" in
    --log-fine)           ARGS+='--log-fine '; shift;;
    --keep-dart-tool|-k)  KEEP_CACHE=1; shift;;
    --help|-h)            echo ""
                          echo "Runs code excerpt updater."
                          echo ""
                          echo "Usage: $(basename $0) [options]"
                          echo ""
                          echo "      --log-fine        Use --log-fine arg"
                          echo "  -k, --keep-dart-tool  Don't delete generated .dart_tool folders"
                          echo "  -h, --help            Print this usage information"
                          echo "";
                          exit 0;;
    *)                    echo "Unrecognized option: $1. Use --help for usage."; exit 0;;
  esac
done


readonly diffVersion="$(diff -v 2>&1 | head -n 1 | awk '{print $NF}')"

if [[ ${diffVersion:0:1} != "3" ]]; then
  echo "diffutils version >=3.6 required - your version: $diffVersion"
  exit 1
fi

if [[ -e "$FRAG" ]]; then 
  echo "=> Deleting old $FRAG"; 
  rm -Rf "$FRAG"; 
fi

# Ensure package_config.json is generated
dart pub get --disable-analytics
dart run build_runner build --delete-conflicting-outputs --config excerpt --output="$FRAG"


if [[ ! -e "$FRAG/examples" ]]; then
  echo "=> ERROR: examples fragments folder was not generated: '$FRAG/examples'"
  exit 1
fi


ARGS+='--yaml '
ARGS+='--no-escape-ng-interpolation '
ARGS+='--replace='

# The replace expressions that follow must not contain (unencode/unescaped) spaces:
ARGS+='/\/\/!<br>//g;' # Use //!<br> to force a line break (against dartfmt)
ARGS+='/ellipsis(<\w+>)?(\(\))?;?/.../g;' # ellipses; --> ...
ARGS+='/\/\*(\s*\.\.\.\s*)\*\//$1/g;' # /*...*/ --> ...
ARGS+='/\{\/\*-(\s*\.\.\.\s*)-\*\/\}/$1/g;' # {/*-...-*/} --> ... (removed brackets too)

# Replace "//!analysis-issue" by, say, "Analysis issue" 
# (although once we can use embedded DPs this won't be needed)?
ARGS+='/\/\/!(analysis-issue|runtime-error)[^\n]*//g;' # Removed warning/error marker
ARGS+='/\x20*\/\/\s+ignore_for_file:[^\n]+\n//g;'      # Remove analyzer ignore-issue marker
ARGS+='/\x20*\/\/\s+ignore:[^\n]+//g;'                 # Remove analyzer ignore-issue marker

echo "-------------------------------"
echo "=> Source:     $SRC"
# During the migration, all excerpt paths start here, meaning null safe 
# excerpt paths begin whatever. After migration, this will not be necessary.
echo "=> Fragments:  $FRAG/examples"
echo "=> Other args: $ARGS"
echo "-------------------------------"


LOG_FILE="$TMP/refresh-code-excerpts.log"

dart run code_excerpt_updater \
      --fragment-dir-path "$FRAG/examples" \
      --src-dir-path examples \
      $ARGS \
      --write-in-place \
      "$SRC" 2>&1 | tee $LOG_FILE
      
if [[ -z "$KEEP_CACHE" ]]; then
  echo "=> Removing cached (.dart_tool)"
  (set -x; rm -r ".dart_tool")
fi

LOG=$(cat $LOG_FILE)
if [[ $LOG == *" 0 out of"* && $LOG != *Error* ]]; then
  exit 0
else
  exit 1
fi
