#!/usr/bin/env bash

pub get
pub run build_runner build --release --output out
cp out/web/dartpad_picker_main.dart.js ../../assets/dash/js
rm -rf out/
