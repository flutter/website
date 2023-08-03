import 'dart:convert';
import 'dart:io';

void main() {
  final firebaseFile = File('firebase.json');

  if (!(firebaseFile.existsSync())) {
    _errorAndExit(
      'Error: Cannot find the firebase.json file in the current directory.',
    );
  }

  try {
    final firebaseConfigString = firebaseFile.readAsStringSync();
    final firebaseConfig = jsonDecode(firebaseConfigString);

    final hostingConfig = firebaseConfig['hosting'];

    if (hostingConfig == null) {
      _errorAndExit(
        "The firebase.json file is missing a top-level 'hosting' entry.",
      );
    }

    final redirects = hostingConfig['redirects'];

    if (redirects == null) {
      stdout.writeln(
        'There are no redirects specified within the firebase.json file.',
      );
      return;
    }

    if (redirects is! List<dynamic>) {
      _errorAndExit(
        "The firebase.json file's 'redirect' entry is not a list.",
      );
    }

    if (redirects.isEmpty) {
      return;
    }

    final sources = <String>{};

    var duplicatesFound = 0;

    for (final redirect in redirects) {
      final source = redirect['source'] ?? redirect['regex'];
      if (source == null) {
        _errorAndExit(
          "The firebase.json file has a "
          "redirect missing a 'source' or 'regex'.",
        );
      }

      if (source is! String) {
        _errorAndExit(
          "The firebase.json redirect $redirect has a "
          "'source' or 'regex' specified which is not a string.",
        );
      }

      if (source.isEmpty) {
        _errorAndExit(
          "The firebase.json redirect $redirect has an "
          "empty 'source' or 'regex'.",
        );
      }

      if (sources.contains(source)) {
        stderr.writeln(
          "Multiple redirects share the '$source' source.",
        );
        duplicatesFound += 1;
      }

      sources.add(source);

      final destination = redirect['destination'];

      if (destination == null) {
        _errorAndExit(
          "The firebase.json file has a "
          "redirect missing a 'destination'.",
        );
      }

      if (destination is! String) {
        _errorAndExit(
          "The firebase.json redirect $redirect has a "
          "'destination' specified which is not a string.",
        );
      }

      if (destination.isEmpty) {
        _errorAndExit(
          "The firebase.json redirect $redirect has "
          "an empty 'destination'.",
        );
      }
    }

    if (duplicatesFound > 0) {
      _errorAndExit(
        '$duplicatesFound duplicate sources found'
        'in the firebase.json redirects.',
      );
    }
  } catch (e) {
    _errorAndExit(
      'Encountered an error when loading the firebase.json file:',
      e,
    );
  }
}

void _errorAndExit(String error, [Object? exception]) {
  stderr.write('Error: ');
  stderr.writeln(error);
  if (exception != null) {
    stderr.writeln(exception.toString());
  }
  exit(1);
}
