import 'package:flutter/material.dart';

class ErrorHandler {
  initialize() async {
    // initialize error handler
  }

  onError(Object error, Object stack) {
    // do something when there's an error
  }

  onErrorDetails(FlutterErrorDetails details) {
    // do something with FlutterErrorDetails
  }
}

ErrorHandler myErrorsHandler = ErrorHandler();
