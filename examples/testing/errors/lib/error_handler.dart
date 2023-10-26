import 'package:flutter/material.dart';

class ErrorHandler {
  Future<void> initialize() async {
    // initialize error handler
  }

  void onError(Object error, Object stack) {
    // do something when there's an error
  }

  void onErrorDetails(FlutterErrorDetails details) {
    // do something with FlutterErrorDetails
  }
}

ErrorHandler myErrorsHandler = ErrorHandler();
