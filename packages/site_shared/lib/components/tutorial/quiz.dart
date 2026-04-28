// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:yaml/yaml.dart';

import '../../src/markdown/markdown_parser.dart';
import 'client/quiz.dart';
import 'models/quiz_model.dart';

class Quiz extends CustomComponent {
  const Quiz() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode || node.tag.toLowerCase() != 'quiz') {
      return null;
    }

    final title = node.attributes['title'];

    // If the quiz has an ID, load it from the page data.
    if (node.attributes['id'] case final String quizId when quizId.isNotEmpty) {
      return Builder(
        builder: (context) {
          final quizzes = context.page.data['quiz'] as Map<String, Object?>?;
          if (quizzes?[quizId] case final List<Object?> quizData) {
            return InteractiveQuiz(
              title: title,
              questions: quizData
                  .map((q) => _parseQuestion(q as Map<String, Object?>))
                  .toList(growable: false),
            );
          }

          throw ArgumentError('Failed to parse quiz with ID: $quizId');
        },
      );
    }

    // If the quiz does not have an ID, parse it from the content.
    if (node.children?.whereType<ElementNode>().isNotEmpty ?? false) {
      throw Exception(
        'Invalid Quiz content. Remove any leading empty lines to '
        'avoid parsing as markdown.',
      );
    }

    final content = node.children?.map((n) => n.innerText).join('\n') ?? '';
    final data = loadYamlNode(content);
    assert(data is YamlList, 'Invalid Quiz content. Expected a YAML list.');
    final questions = (data as YamlList).nodes
        .map((n) => Question.fromMap(n as YamlMap))
        .toList();
    assert(questions.isNotEmpty, 'Quiz must contain at least one question.');
    return InteractiveQuiz(title: title, questions: questions);
  }
}

Question _parseQuestion(Map<Object?, Object?> map) => Question(
  parseMarkdownToHtml(map['question'] as String, inline: true),
  (map['options'] as List<Object?>)
      .map((e) => _parseAnswer(e as Map<Object?, Object?>))
      .toList(),
);

AnswerOption _parseAnswer(Map<Object?, Object?> map) => AnswerOption(
  parseMarkdownToHtml(map['text'] as String, inline: true),
  map['correct'] as bool? ?? false,
  parseMarkdownToHtml(map['explanation'] as String),
);
