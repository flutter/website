// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../../models/quiz_model.dart';
import '../../../util.dart';
import '../../common/button.dart';

@client
class InteractiveQuiz extends StatefulComponent {
  const InteractiveQuiz({
    required this.title,
    required this.questions,
    super.key,
  });

  final String? title;
  final List<Question> questions;

  @override
  State<InteractiveQuiz> createState() => _InteractiveQuizState();
}

class _InteractiveQuizState extends State<InteractiveQuiz> {
  final quizKey = GlobalNodeKey<web.HTMLElement>();
  final nextButtonKey = GlobalNodeKey<web.HTMLElement>();

  int currentQuestionIndex = 0;
  List<int> selectedOptionIndices = [];

  Question? get currentQuestion {
    if (currentQuestionIndex >= component.questions.length) {
      return null;
    }
    return component.questions[currentQuestionIndex];
  }

  AnswerOption? get selectedOption {
    final question = currentQuestion;
    if (question == null ||
        selectedOptionIndices.length <= currentQuestionIndex) {
      return null;
    }
    return question.options[selectedOptionIndices[currentQuestionIndex]];
  }

  void toggleOption(int index, [bool fromKeyboard = false]) {
    if (selectedOption != null) {
      return;
    }
    setState(() {
      if (selectedOptionIndices.length <= currentQuestionIndex) {
        selectedOptionIndices.add(index);
      } else {
        selectedOptionIndices[currentQuestionIndex] = index;
      }
    });
    if (fromKeyboard) {
      context.binding.addPostFrameCallback(() {
        // Move focus to the next button.
        final nextButton = nextButtonKey.currentNode;
        nextButton?.focus();
      });
    }
  }

  @override
  Component build(BuildContext context) {
    return div(key: quizKey, classes: 'quiz not-content', [
      if (component.title case final title?)
        h3(classes: 'quiz-title', [
          .text(title),
        ]),
      span(classes: 'quiz-progress', [
        .text(
          currentQuestion != null
              ? '${currentQuestionIndex + 1} / ${component.questions.length}'
              : 'Complete',
        ),
      ]),
      for (final question in component.questions)
        div(
          classes: [
            'quiz-question',
            if (question == currentQuestion) 'active',
          ].toClasses,
          [
            strong([.text(question.question)]),
            ol([
              for (final (index, option) in question.options.indexed)
                li(
                  attributes: {
                    'role': 'button',
                    if (selectedOption == null) 'tabindex': '0',
                    if (option == selectedOption) 'aria-pressed': 'true',
                    if (selectedOption != null) 'aria-disabled': 'true',
                  },
                  events: {
                    'click': (_) {
                      toggleOption(index);
                    },
                    'keyup': (event) {
                      if ((event as web.KeyboardEvent).key == 'Enter' ||
                          event.key == ' ') {
                        toggleOption(index, true);
                      }
                    },
                  },
                  [
                    div(classes: 'question-wrapper', [
                      div(classes: 'question', [
                        p([.text(option.text)]),
                      ]),
                      div(classes: 'solution', [
                        if (option.correct)
                          const p(classes: 'correct', [.text('That\'s right!')])
                        else
                          const p(classes: 'incorrect', [.text('Not quite')]),
                        p([.text(option.explanation)]),
                      ]),
                    ]),
                  ],
                ),
            ]),
          ],
        ),

      if (currentQuestion == null)
        const div(classes: 'quiz-complete', [
          strong([.text('Great job!')]),
          p([.text('You completed the quiz.')]),
        ]),
      div(classes: 'quiz-actions', [
        Button(
          classes: ['quiz-button', 'secondary'],
          style: ButtonStyle.filled,
          disabled: currentQuestionIndex == 0,
          onClick: () {
            setState(() {
              currentQuestionIndex--;
            });
          },
          content: 'Previous',
        ),
        Button(
          key: nextButtonKey,
          classes: ['quiz-button'],
          style: ButtonStyle.filled,
          disabled: currentQuestion != null && selectedOption == null,
          onClick: () {
            if (currentQuestion == null) {
              // Restart the quiz.
              setState(() {
                currentQuestionIndex = 0;
                selectedOptionIndices = [];
              });
              return;
            }
            if (selectedOption == null) return;
            final correct = selectedOption!.correct;
            setState(() {
              if (correct) {
                currentQuestionIndex++;
              } else {
                // Clear the selected option to allow retry.
                selectedOptionIndices.removeLast();
              }
            });
          },
          content: switch ((
            currentQuestion == null,
            currentQuestionIndex == component.questions.length - 1,
            selectedOption?.correct,
          )) {
            // (isComplete, isLast, isCorrect)
            (true, _, _) => 'Restart',
            (false, _, false) => 'Try again',
            (false, false, _) => 'Next question',
            (false, true, _) => 'Finish quiz',
          },
        ),
      ]),
    ]);
  }
}
