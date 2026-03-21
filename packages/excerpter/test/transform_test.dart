// Copyright (c) 2023. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

import 'package:excerpter/excerpter.dart';
import 'package:test/test.dart';

void main() {
  group('Pattern transforms', _patternTransforms);
  group('Amount transforms', _amountTransforms);
  group('Replace transforms', _replaceTransforms);
  group('String to replace transforms', _stringToReplaceTransforms);
}

void _patternTransforms() {
  test('retain all', () {
    final all = ['aaa', 'aabb', 'abc', 'aacc'];
    expect(RetainTransform('a').transform(all), orderedEquals(all));
  });

  test('retain some', () {
    expect(
      RetainTransform('b').transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals(['aabb', 'abc']),
    );
  });

  test('retain none', () {
    expect(
      RetainTransform('d').transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals([]),
    );
  });

  test('remove all', () {
    final all = ['aaa', 'aabb', 'abc', 'aacc'];
    expect(RemoveTransform('a').transform(all), orderedEquals([]));
  });

  test('remove some', () {
    expect(
      RemoveTransform('b').transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals(['aaa', 'cccc']),
    );
  });

  test('remove none', () {
    final all = ['aaa', 'aabb', 'abc', 'cccc'];
    expect(RemoveTransform('d').transform(all), orderedEquals(all));
  });

  test('from all', () {
    final all = ['aaa', 'aabb', 'abc', 'aacc'];
    expect(FromTransform('aaa').transform(all), orderedEquals(all));
  });

  test('from some', () {
    expect(
      FromTransform('abc').transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals(['abc', 'cccc']),
    );
  });

  test('from none', () {
    expect(
      FromTransform('d').transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals([]),
    );
  });

  test('to all', () {
    final all = ['aaa', 'aabb', 'abc', 'aacc'];
    expect(ToTransform('aacc').transform(all), orderedEquals(all));
  });

  test('to some', () {
    expect(
      ToTransform('aabb').transform(['aaa', 'aabb', 'abc', 'aacc']),
      orderedEquals(['aaa', 'aabb']),
    );
  });

  test('to none', () {
    final all = ['aaa', 'aabb', 'abc', 'cccc'];
    expect(ToTransform('d').transform(all), orderedEquals(all));
  });
}

void _amountTransforms() {
  test('skip negative', () {
    expect(
      SkipTransform(-2).transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals(['aaa', 'aabb']),
    );
  });

  test('skip zero', () {
    final all = ['aaa', 'aabb', 'abc', 'cccc'];
    expect(SkipTransform(0).transform(all), orderedEquals(all));
  });

  test('skip positive', () {
    expect(
      SkipTransform(2).transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals(['abc', 'cccc']),
    );
  });

  test('skip all', () {
    expect(
      SkipTransform(4).transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals([]),
    );
  });

  test('take negative', () {
    expect(
      TakeTransform(-2).transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals(['abc', 'cccc']),
    );
  });

  test('take zero', () {
    expect(
      TakeTransform(0).transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals([]),
    );
  });

  test('take positive', () {
    expect(
      TakeTransform(2).transform(['aaa', 'aabb', 'abc', 'cccc']),
      orderedEquals(['aaa', 'aabb']),
    );
  });

  test('take all', () {
    final all = ['aaa', 'aabb', 'abc', 'cccc'];
    expect(TakeTransform(4).transform(all), orderedEquals(all));
  });

  test('indent negative', () {
    expect(() => IndentTransform(-2), throwsA(isA<AssertionError>()));
  });

  test('indent zero', () {
    final all = ['a', ' b', '  c'];
    expect(IndentTransform(0).transform(all), orderedEquals(all));
  });

  test('indent positive', () {
    expect(
      IndentTransform(1).transform(['a', ' b', '  c']),
      orderedEquals([' a', '  b', '   c']),
    );
  });
}

void _replaceTransforms() {
  test('replace simple some', () {
    expect(
      SimpleReplaceTransform(
        RegExp('Hello'),
        'Halo',
      ).transform(['Hello world!!', 'Bye!']),
      orderedEquals(['Halo world!!', 'Bye!']),
    );
  });

  test('replace simple split', () {
    expect(
      SimpleReplaceTransform(
        RegExp('Hi\nDash'),
        'Bye\nFriends',
      ).transform(['Hi', 'Dash!']),
      orderedEquals(['Bye', 'Friends!']),
    );
  });

  test('replace backreferences single capture group', () {
    expect(
      BackReferenceReplaceTransform(
        RegExp('(Hello )Dash'),
        r'$1World',
      ).transform(['Hello Dash']),
      orderedEquals(['Hello World']),
    );
  });

  test('replace backreferences entire captured', () {
    expect(
      BackReferenceReplaceTransform(
        RegExp('Hello Dash'),
        r'[!$&!]',
      ).transform(['Hello Dash, you are very blue.']),
      orderedEquals(['[!Hello Dash!], you are very blue.']),
    );
  });
}

void _stringToReplaceTransforms() {
  Never errorNotExpected(String error) {
    fail('Error not expected - $error');
  }

  Never errorExpected(String error) {
    throw _ExpectedException();
  }

  test('empty', () {
    expect(
      () => stringToReplaceTransforms('', errorExpected),
      throwsA(isA<_ExpectedException>()),
    );
  });

  test('missing ending', () {
    expect(
      () => stringToReplaceTransforms('/Hello/Halo/', errorExpected),
      throwsA(isA<_ExpectedException>()),
    );
  });

  test('single replace', () {
    final simpleReplace = stringToReplaceTransforms(
      '/Hello/Hi/g;',
      errorNotExpected,
    );
    expect(simpleReplace.length, equals(1));
    expect(simpleReplace.first.from, equals(RegExp('Hello', multiLine: true)));
    expect(simpleReplace.first.to, equals('Hi'));
  });

  test('multiple replace', () {
    final multipleReplace = stringToReplaceTransforms(
      '/Hello/Hi/g;/World/Dash/g;',
      errorNotExpected,
    );
    expect(multipleReplace.length, equals(2));
  });
}

final class _ExpectedException implements Exception {}
