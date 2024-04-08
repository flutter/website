import 'package:flutter/material.dart';

class ErrorHandler {
  Future<void> initialize() async {
    // Initialize error handler.
  }

  void onError(Object error, Object stack) {
    // Do something when there's an error.
  }

  void onErrorDetails(FlutterErrorDetails details) {
    // Do something with FlutterErrorDetails.
  }
}

ErrorHandler myErrorsHandler = ErrorHandler();
