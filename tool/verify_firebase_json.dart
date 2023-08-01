import 'dart:convert';
import 'dart:io';

void main() {
  final firebaseFile = File('firebase.json');

  if (!(firebaseFile.existsSync())) {
    stderr.writeln(
      'Error: Cannot find the firebase.json file in the current directory.',
    );
    exit(1);
  }

  try {
    final firebaseConfigString = firebaseFile.readAsStringSync();
    final firebaseConfig = jsonDecode(firebaseConfigString);

    final hostingConfig = firebaseConfig['hosting'];

    if (hostingConfig == null) {
      stderr.writeln(
        "Error: The firebase.json file is missing a top-level 'hosting' entry.",
      );
      exit(1);
    }

    final redirects = hostingConfig['redirects'];

    if (redirects == null) {
      stdout.writeln(
        'There are no redirects specified within the firebase.json file.',
      );
      return;
    }

    if (redirects is! List<dynamic>) {
      stderr.writeln(
        "Error: The firebase.json file's 'redirect' entry is not a list.",
      );
      exit(1);
    }

    if (redirects.isEmpty) {
      return;
    }

    final sources = <String>{};

    var duplicatesFound = 0;

    for (final redirect in redirects) {
      final source = redirect['source'] ?? redirect['regex'];
      if (source == null) {
        stderr.writeln(
          "Error: The firebase.json file has a redirect missing a 'source' or 'regex'.",
        );
        exit(1);
      }

      if (source is! String) {
        stderr.writeln(
          "Error: The firebase.json redirect $redirect has a 'source' or 'regex' specified which is not a string.",
        );
        exit(1);
      }

      if (source.isEmpty) {
        stderr.writeln(
          "Error: The firebase.json redirect $redirect has an empty 'source' or 'regex'.",
        );
        exit(1);
      }

      if (sources.contains(source)) {
        stderr.writeln(
          "Error: Multiple redirects share the '$source' source.",
        );
        duplicatesFound += 1;
      }

      sources.add(source);

      final destination = redirect['destination'];

      if (destination == null) {
        stderr.writeln(
          "Error: The firebase.json file has a redirect missing a 'destination'.",
        );
        exit(1);
      }

      if (destination is! String) {
        stderr.writeln(
          "Error: The firebase.json redirect $redirect has a 'destination' specified which is not a string.",
        );
        exit(1);
      }

      if (destination.isEmpty) {
        stderr.writeln(
          "Error: The firebase.json redirect $redirect has an empty 'destination'.",
        );
        exit(1);
      }
    }

    if (duplicatesFound > 0) {
      stderr.writeln(
        'Error: $duplicatesFound duplicate sources found in the firebase.json redirects.',
      );
      exit(1);
    }
  } catch (e) {
    stderr.writeln(
      'Error: Encountered an error when loading the firebase.json file:',
    );
    print(e.toString());
    exit(1);
  }
}
