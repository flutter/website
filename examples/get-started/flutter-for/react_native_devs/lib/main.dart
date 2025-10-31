// ignore_for_file: avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

// #docregion main
/// Dart
void main() {}
// #enddocregion main

void printCode() {
  // #docregion print
  /// Dart
  print('Hello world!');
  // #enddocregion print
}

void variableCode() {
  // #docregion variables
  /// Dart
  /// Both variables are acceptable.
  String name = 'dart'; // Explicitly typed as a [String].
  var otherName = 'Dart'; // Inferred [String] type.
  // #enddocregion variables
}

void nullCode() {
  // #docregion null
  // Dart
  var name; // == null; raises a linter warning
  int? x; // == null
  // #enddocregion null
}

int? potentiallyNull() => null;

void trueExample() {
  // #docregion true
  /// Dart
  var myNull = potentiallyNull();
  if (myNull == null) {
    print('use "== null" to check null');
  }
  var zero = 0;
  if (zero == 0) {
    print('use "== 0" to check zero');
  }
  // #enddocregion true
}

// #docregion function
/// Dart
/// You can explicitly define the return type.
bool fn() {
  return true;
}

// #enddocregion function
