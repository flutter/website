# This bash file is meant to be source'd from the repo root, not executed.

source tool/shared/env-set.sh

# Site-specific settings here: currently, none.

export FLUTTER_ROOT=flutter
export FLUTTER_BIN="$FLUTTER_ROOT/bin"

if [[ ! -e "$FLUTTER_ROOT" ]]; then
  echo "ERROR: The ~/flutter git submodule is missing. For initialization instructions, see the repo README."
  exit 1;
fi
