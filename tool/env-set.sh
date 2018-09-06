# This bash file is meant to be source'd, not executed.

source tool/shared/env-set.sh

# Temporary, until we start using site-shared:

# nvm install 10
# nvm use 10
# rvm install 2.4.3
# rvm use 2.4.3

# function travis_fold () { true; }
# export -f travis_fold

# : ${TMP:=tmp}
# [[ -e "$TMP" ]] || mkdir -pv "$TMP"

# Site specific settings here: currently, none.
