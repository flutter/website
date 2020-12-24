#!/usr/bin/env bash

set -e -o pipefail

readonly rootDir="$(cd "$(dirname "$0")/.." && pwd)"

readonly diffVersion="$(diff -v 2>&1 | head -n 1 | awk '{print $NF}')"

if [[ ${diffVersion:0:1} != "3" ]]; then
  echo "Unsupported diff version ${diffVersion}. Please install diffutils version 3.6 or higher."
  echo "On macOS, you can run 'brew install diffutils'."
  exit 1
fi

function usage() {
  echo $1; echo
  echo "Usage: $(basename $0) [--help] [-k|--keep-dart-tool] [path-to-src-file-or-folder]"
  echo
  exit 1;
}

ARGS=''

while [[ "$1" == -* ]]; do
  case "$1" in
    --log-fine) ARGS+='--log-fine '; shift;;
    -k|--keep-dart-tool) KEEP_CACHE=1; shift;;
    -h|--help)  usage;;
  esac
done

[[ -z "$DART_SITE_ENV_DEFS" ]] && . $rootDir/tool/env-set.sh
[[ -z "$DART_SITE_ENV_DEFS" ]] && exit 1; # env-set failed, abort.

# Use the version of pub from the Flutter repository instead of whatever
# version is in the PATH.
pub="$FLUTTER_ROOT/bin/cache/dart-sdk/bin/pub"

TMP="$rootDir/tmp"
FRAG="$TMP/_fragments"

if [[ -e "$FRAG" ]]; then echo Deleting old "$FRAG"; rm -Rf "$FRAG"; fi

# ensure package_config.json is generated
$pub get

ARGS+='--yaml '
if [[ ! -e "pubspec.lock" ]]; then pub get; fi
$pub run build_runner build --delete-conflicting-outputs --config excerpt --output="$FRAG"

if [[ ! -e "$FRAG/examples" ]]; then
  usage "ERROR: examples fragments folder was not generated: '$FRAG/examples'"
fi

if [[ ! -e "$FRAG/null_safety_examples" ]]; then
  usage "ERROR: null_safety_examples fragments folder was not generated: '$FRAG/null_safety_examples'"
fi

SRC="$1"
: ${SRC:="$rootDir/src"}
[[ -e $SRC ]] || usage "ERROR: source file/folder does not exist: '$SRC'"

ARGS+='--no-escape-ng-interpolation '
# ARGS+='--plaster=none '
ARGS+='--replace='
# The replace expressions that follow must not contain (unencode/unescaped) spaces:
ARGS+='/\/\/!<br>//g;' # Use //!<br> to force a line break (against dartfmt)
ARGS+='/ellipsis(<\w+>)?(\(\))?;?/.../g;' # ellipses; --> ...
ARGS+='/\/\*(\s*\.\.\.\s*)\*\//$1/g;' # /*...*/ --> ...
ARGS+='/\{\/\*-(\s*\.\.\.\s*)-\*\/\}/$1/g;' # {/*-...-*/} --> ... (removed brackets too)
# Replace "//!analysis-issue" by, say, "Analysis issue" (although once we can use embedded DPs this won't be needed)?
ARGS+='/\/\/!(analysis-issue|runtime-error)[^\n]*//g;' # Removed warning/error marker
ARGS+='/\x20*\/\/\s+ignore_for_file:[^\n]+\n//g;' # Remove analyzer ignore-issue marker
ARGS+='/\x20*\/\/\s+ignore:[^\n]+//g;' # Remove analyzer ignore-issue marker

echo "Source:     $SRC"
# During the migration, all excerpt paths start here, meaning null safe excerpt
# paths begin `../null_safety_examples/whatever`. After migration, this will not
# be necessary.
echo "Fragments:  $FRAG/examples"
echo "Other args: $ARGS"
echo
LOG_FILE="$TMP/refresh-code-excerpts-log.txt"
$pub run code_excerpt_updater \
  --fragment-dir-path "$FRAG/examples" \
  --src-dir-path examples \
  $ARGS \
  --write-in-place \
  "$SRC" 2>&1 | tee $LOG_FILE
LOG=$(cat $LOG_FILE)

if [[ -z "$KEEP_CACHE" ]]; then
  (set -x; rm -r "$rootDir/.dart_tool/")
fi

[[ $LOG == *" 0 out of"* && $LOG != *Error* ]]
