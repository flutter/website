#!/usr/bin/env bash

: ${TMP:=tmp}

set -x

dart pub get
dart run build_runner build --output $TMP --define "build_web_compilers|entrypoint=compiler=dart2js"
cp $TMP/web/* ../../assets/js
rm -rf $TMP
