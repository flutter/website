# Temporary: copy of site-shared/tool/shared/env-set.sh
#
# - This script will be sourced from the host repo's REPO_ROOT/tool folder.
# - REPO_ROOT/scripts/shared symlinks to site-shared/tool.
# - REPO_ROOT contains `_config.yml` with a `port` field.

_DART_SITE_ENV_SET_INSTALL_OPT="--install"

if [[ $# -gt 0 ]]; then
  case "$1" in
    -h|--help)  echo "source scripts/env-set.sh [--quick|--no-install]"
                echo
                echo "  Runs nvm and rvm commands 'install' and 'use' to get required Node"
                echo "  and Ruby versions; then sets other required environment variables."
                echo
                echo "  --no-install  Skips nvm and rvm 'install' in favor of 'use'."
                echo "  --quick       Do nothing if this script has already been sourced."
                echo
                return 0;;
    -q|--quick) _DART_SITE_ENV_SET_INSTALL_OPT="--quick"; shift;;
    -n|--no-install)
                _DART_SITE_ENV_SET_INSTALL_OPT="--no-install"; shift;;
    *)          echo "ERROR: Unrecognized option for env-set.sh: $1. Use --help for details."
                return 1;;
  esac
fi

if [[ $# -gt 0 ]]; then
  echo "ERROR: too many arguments passed to env-set.sh: $1. Use --help for details."
  return 1
fi

if [[ "$_DART_SITE_ENV_SET_INSTALL_OPT" != "--quick" ]]; then
  unset DART_SITE_ENV_DEFS
fi

if [[ -z "$(type -t rvm)" ]]; then
  echo "ERROR: rvm not installed. See README setup instructions. Skipping setup."
elif [[ -z "$(type -t nvm)" ]]; then
  echo "ERROR: nvm not installed. See README setup instructions. Skipping setup."
elif [[ -z "$DART_SITE_ENV_DEFS" ]]; then
  export DART_SITE_ENV_DEFS=1
  export ANSI_YELLOW="\033[33;1m"
  export ANSI_RESET="\033[0m"
  echo -e "${ANSI_YELLOW}Setting environment variables from tool/env-set.sh${ANSI_RESET}"

  if [[ "$_DART_SITE_ENV_SET_INSTALL_OPT" == "--install" ]]; then
    nvm install 10
  else
    nvm use 10
  fi
  source tool/shared/get-ruby.sh "$_DART_SITE_ENV_SET_INSTALL_OPT"

  if [ ! $(type -t travis_fold) ]; then
      # In case this is being run locally. Turn travis_fold into a noop.
      travis_fold () { true; }
  fi
  export -f travis_fold

  case "$(uname -a)" in
      Darwin\ *) _OS_NAME=macos ;;
      Linux\ *) _OS_NAME=linux ;;
      *) _OS_NAME=linux ;;
  esac
  export _OS_NAME

  : ${TMP:=$HOME/tmp}
  : ${PKG:=$TMP/pkg}
  export TMP
  export PKG

  if [[ -n "$TRAVIS" ]]; then
    [[ ! -d "$TMP" ]] && mkdir "$TMP"
    [[ ! -d "$PKG" ]] && mkdir "$PKG"
  else
    if [[ -z "$(type -t dart)" && ! $PATH =~ \/dart-sdk ]]; then
        export DART_SDK="$PKG/dart-sdk"
        # Updating PATH to include access to Dart bin.
        export PATH="$PATH:$DART_SDK/bin"
        export PATH="$PATH:$HOME/.pub-cache/bin"
    fi
  fi

  export SITE_LOCALHOST_PORT=5000
  if [[ ! -e _config.yml ]]; then
    echo "WARNING: '_config.yml' file not found; setting SITE_LOCALHOST_PORT to $SITE_LOCALHOST_PORT."
  else
    export SITE_LOCALHOST_PORT=$(grep '^port:' _config.yml | awk '{ print $2}')
    if [[ -z $SITE_LOCALHOST_PORT ]]; then
      echo "WARNING: '_config.yml' file has no 'port' field; setting SITE_LOCALHOST_PORT to $SITE_LOCALHOST_PORT.";
    fi
  fi

  if [[ -z $(git config push.recurseSubmodules) ]]; then
    echo "INFO: git config push.recurseSubmodules is unset. Setting it to 'check':"
    (set -x; git config push.recurseSubmodules check)
  else
    echo "INFO: git config push.recurseSubmodules is set to $(git config push.recurseSubmodules)."
  fi
  git config status.submodulesummary 1
  echo "INFO: git config status.submodulesummary is set to $(git config status.submodulesummary)."

fi

return 0
