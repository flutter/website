// ignore_for_file: avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

// #docregion Main
/// Dart
void main() {}
// #enddocregion Main

void printCode() {
  // #docregion Print
  /// Dart
  print('Hello world!');
  // #enddocregion Print
}

void variableCode() {
  // #docregion Variables
  /// Dart
  /// Both variables are acceptable.
  String name = 'dart'; // Explicitly typed as a [String].
  var otherName = 'Dart'; // Inferred [String] type.
  // #enddocregion Variables
}

void nullCode() {
  // #docregion Null
  // Dart
  var name; // == null; raises a linter warning
  int? x; // == null
  // #enddocregion Null
}

void trueExample() {
  // #docregion True
  /// Dart
  var myNull;
  if (myNull == null) {
    print('use "== null" to check null');
  }
  var zero = 0;
  if (zero == 0) {
    print('use "== 0" to check zero');
  }
  // #enddocregion True
}

// #docregion Function
/// Dart
/// You can explicitly define the return type.
bool fn() {
  return true;
}
// #enddocregion Function
