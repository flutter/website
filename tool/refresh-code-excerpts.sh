#!/usr/bin/env bash

set -e -o pipefail

readonly rootDir="$(cd "$(dirname "$0")/.." && pwd)"

function usage() {
  echo $1; echo
  echo "Usage: $(basename $0) [--help] [--legacy] [path-to-src-file-or-folder]"
  echo
  exit 1;
}

if [[ $1 == '-h' || $1 == '--help' ]]; then usage; fi

[[ -z "$DART_SITE_ENV_DEFS" ]] && . $rootDir/tool/env-set.sh
[[ -z "$DART_SITE_ENV_DEFS" ]] && exit 1; # env-set failed, abort.

# Use the version of pub from the Flutter repository instead of whatever
# version is in the PATH.
pub="$FLUTTER_ROOT/bin/cache/dart-sdk/bin/pub"

ARGS=''
TMP="$rootDir/tmp"
FRAG="$TMP/_fragments"

if [[ -e "$FRAG" ]]; then echo Deleting old "$FRAG"; rm -Rf "$FRAG"; fi

if [[ $1 == '--legacy' ]]; then
  shift
  npx code-excerpter examples "$FRAG"
else
  ARGS+='--yaml '
  if [[ ! -e "pubspec.lock" ]]; then pub get; fi
  "$pub" run build_runner build --delete-conflicting-outputs --config excerpt --output="$FRAG"
  FRAG+=/examples
fi

[[ -e "$FRAG" ]] || usage "ERROR: fragments folder was not generated: '$FRAG'"

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
echo "Fragments:  $FRAG"
echo "Other args: $ARGS"
echo
LOG_FILE="$TMP/refresh-code-excerpts-log.txt"
"$pub" run code_excerpt_updater \
  --fragment-dir-path "$FRAG" \
  --src-dir-path examples \
  $ARGS \
  --write-in-place \
  "$SRC" 2>&1 | tee $LOG_FILE
LOG=$(cat $LOG_FILE)

echo "Cleaning up .dart_tool/"
rm -r "$rootDir/.dart_tool/"

[[ $LOG == *" 0 out of"* && $LOG != *Error* ]]
