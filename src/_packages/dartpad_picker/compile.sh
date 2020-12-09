#!/usr/bin/env bash

: ${TMP:=tmp}

set -x

pub get
pub run build_runner build --release --output $TMP
cp $TMP/web/dartpad_picker_main.dart.js ../../assets/js
rm -rf $TMP
