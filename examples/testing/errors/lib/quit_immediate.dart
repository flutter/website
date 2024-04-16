// ignore_for_file: directives_ordering

import './my_app.dart';

// #docregion on-error-main
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MyApp());
}

// The rest of the `flutter create` code...
// #enddocregion on-error-main
