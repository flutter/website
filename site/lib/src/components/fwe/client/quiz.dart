// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';

import '../../../util.dart';
import '../../common/button.dart';

@client
class InteractiveQuiz extends StatefulComponent {
  const InteractiveQuiz({required this.question, super.key});

  final Question question;

  @override
  State<InteractiveQuiz> createState() => _InteractiveQuizState();
}

class _InteractiveQuizState extends State<InteractiveQuiz> {
  int? selectedOption;

  @override
  Component build(BuildContext context) {
    return div([
      strong([text(component.question.question)]),
      ol([
        for (final (index, option) in component.question.options.indexed)
          li(
            classes: [
              if (selectedOption != null)
                if (selectedOption == index) 'selected' else 'disabled',
            ].toClasses,
            events: {
              'click': (_) {
                if (selectedOption != null) {
                  return;
                }
                setState(() {
                  selectedOption = index;
                });
              },
            },
            [
              div(classes: 'question-wrapper', [
                div(classes: 'question', [
                  p([text(option.text)]),
                ]),
                div(classes: 'solution', [
                  if (option.correct)
                    p(classes: 'correct', [text('That\'s right!')])
                  else
                    p(classes: 'incorrect', [text('Not quite')]),
                  p([text(option.explanation)]),
                ]),
              ]),
            ],
          ),
      ]),

      Button(
        classes: ['quiz-button'],
        style: ButtonStyle.filled,
        disabled: selectedOption == null,
        onClick: () {
          setState(() {
            selectedOption = null;
          });
        },
        content: selectedOption == null || component.question.options[selectedOption!].correct
            ? 'Next question'
            : 'Try again',
      ),
    ]);
  }
}

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
