// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:yaml/yaml.dart';

import '../../models/quiz_model.dart';
import 'client/quiz.dart';

class Quiz extends CustomComponent {
  const Quiz() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is ElementNode && node.tag.toLowerCase() == 'quiz') {
      if (node.children?.whereType<ElementNode>().isNotEmpty ?? false) {
        throw Exception(
          'Invalid Quiz content. Remove any leading empty lines to '
          'avoid parsing as markdown.',
        );
      }

      final title = node.attributes['title'];

      final content = node.children?.map((n) => n.innerText).join('\n') ?? '';
      final data = loadYamlNode(content);
      assert(data is YamlList, 'Invalid Quiz content. Expected a YAML list.');
      final questions = (data as YamlList).nodes
          .map((n) => Question.fromMap(n as YamlMap))
          .toList();
      assert(questions.isNotEmpty, 'Quiz must contain at least one question.');
      return InteractiveQuiz(title: title, questions: questions);
    }
    return null;
  }
}
