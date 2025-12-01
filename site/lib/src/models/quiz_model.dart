// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

class Question {
  const Question(this.question, this.options);

  final String question;
  final List<AnswerOption> options;

  @decoder
  factory Question.fromMap(Map<Object?, Object?> json) {
    return Question(
      json['question'] as String,
      (json['options'] as List<Object?>)
          .map((e) => AnswerOption.fromJson(e as Map<Object?, Object?>))
          .toList(),
    );
  }

  @encoder
  Map<Object?, Object?> toJson() => {
    'question': question,
    'options': options.map((e) => e.toJson()).toList(),
  };
}

class AnswerOption {
  const AnswerOption(this.text, this.correct, this.explanation);

  final String text;
  final bool correct;
  final String explanation;

  @decoder
  factory AnswerOption.fromJson(Map<Object?, Object?> json) {
    return AnswerOption(
      json['text'] as String,
      json['correct'] as bool? ?? false,
      json['explanation'] as String,
    );
  }

  @encoder
  Map<Object?, Object?> toJson() => {
    'text': text,
    'correct': correct,
    'explanation': explanation,
  };
}
