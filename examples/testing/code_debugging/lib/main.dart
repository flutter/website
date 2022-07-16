import 'dart:io';
// #docregion log
import 'dart:developer' as developer;

void main() {
  developer.log('log me', name: 'my.app.category');

  developer.log('log me 1', name: 'my.other.category');
  developer.log('log me 2', name: 'my.other.category');
}
// #enddocregion log

void output() {
  // #docregion stderr
  stderr.writeln('print me');
  // #enddocregion stderr
}
