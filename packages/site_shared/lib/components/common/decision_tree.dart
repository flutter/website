// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Interactive decision tree component for guiding readers through a sequence
/// of architectural or tooling questions toward a tailored recommendation.
///
/// ## How it works
///
/// `<DecisionTree>` follows the same server-rendered + progressive-enhancement
/// pattern as `<SummaryCard>`, `<Stepper>`, and `<DashTabs>`:
///
/// 1. **Server rendering (`DecisionTree` / `DecisionTreeComponent`)**:
///    At build time, `DecisionTree` parses YAML content (either inline inside
///    `<DecisionTree>...</DecisionTree>` or referenced by `id` from page data
///    such as `src/data/decision_tree.yaml`) and renders semantic HTML for all
///    steps and recommendation cards. This avoids `@client` island codegen
///    (`build_runner` / `main.*.options.dart`), keeps package/SDK upgrades
///    friction-free, and allows nested Markdown (`DashMarkdown`) for links,
///    inline code, lists, and callouts.
/// 2. **Client interactivity (`_setUpDecisionTrees` in `global_scripts.dart`)**:
///    In the browser, selecting an option highlights the active choice and
///    reveals either the next question step (`next_step`) or the matching
///    recommendation card (`recommendation`). Users can change an earlier
///    answer at any time (which automatically clears downstream selections),
///    click **Start over** to reset, or click **Show all paths** to compare
///    every step and recommendation side by side.
///
/// ## Authoring a decision tree in Markdown
///
/// Embed `<DecisionTree>` directly in a Markdown page with inline YAML:
///
/// ```markdown
/// <DecisionTree>
/// steps:
///   - id: q1
///     question: Do you need to write a small amount of native glue code?
///     description: >-
///       Select the option that best matches your project constraints.
///     callout:
///       type: important
///       title: Migrating from Method Channels?
///       content: >-
///         If you are migrating an existing plugin, select **Yes**.
///     options:
///       - label: "Yes: I want to write small glue code"
///         subtitle: Best for calling platform-specific APIs.
///         icon: code
///         recommendation: pigeon
///       - label: "No: I want direct bindings"
///         subtitle: Best for large existing libraries.
///         icon: terminal
///         next_step: q2
/// # Recommendations
/// recommendations:
///   - id: pigeon
///     title: Use Pigeon
///     icon: check_circle
///     description: >-
///       Use **[Pigeon](/interop/pigeon)** to generate type-safe channels.
///     link: /interop/pigeon
///     link_text: Learn about Pigeon
/// </DecisionTree>
/// ```
///
/// > **Important (CommonMark HTML block rule):** Do not leave completely blank
/// > lines inside an inline `<DecisionTree>...</DecisionTree>` block, because
/// > CommonMark ends raw HTML blocks at the first blank line. Use `#` YAML
/// > comment lines for visual spacing between sections, or store the YAML in
/// > `src/data/decision_tree.yaml` and reference it with
/// > `<DecisionTree id="your_tree_id" />`.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:yaml/yaml.dart';

import '../../src/markdown/markdown_parser.dart';
import '../../util.dart';
import 'button.dart';
import 'material_icon.dart';

/// Custom Markdown component that parses `<DecisionTree>` blocks.
final class DecisionTree extends CustomComponent {
  const DecisionTree() : super.base();

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node is! ElementNode || node.tag.toLowerCase() != 'decisiontree') {
      return null;
    }

    final title = node.attributes['title'];

    // Support loading a decision tree by ID from page/site data
    // (for example, `src/data/decision_tree.yaml` or page frontmatter).
    if (node.attributes['id'] case final String treeId when treeId.isNotEmpty) {
      return Builder(
        builder: (context) {
          final trees =
              context.page.data['decision_tree'] as Map<String, Object?>?;
          if (trees?[treeId] case final Map<Object?, Object?> treeData) {
            return DecisionTreeComponent(
              title: title,
              model: DecisionTreeModel.fromMap(treeData),
            );
          }

          throw ArgumentError(
            'Failed to find decision_tree entry with id "$treeId" in page data.',
          );
        },
      );
    }

    if (node.children?.whereType<ElementNode>().isNotEmpty ?? false) {
      throw Exception(
        'Invalid DecisionTree content. Avoid blank lines inside '
        '<DecisionTree>...</DecisionTree> (use "#" YAML comment lines for '
        'spacing) so CommonMark does not split the HTML block.',
      );
    }

    final content = node.children?.map((n) => n.innerText).join('\n') ?? '';
    final data = loadYamlNode(content);
    if (data is! YamlMap) {
      throw ArgumentError(
        'Invalid DecisionTree content. Expected a YAML map with "steps" and '
        '"recommendations".',
      );
    }

    final model = DecisionTreeModel.fromMap(data);
    return DecisionTreeComponent(title: title, model: model);
  }
}

/// Renders an interactive decision tree from a [DecisionTreeModel].
final class DecisionTreeComponent extends StatelessComponent {
  const DecisionTreeComponent({super.key, required this.model, this.title});

  final DecisionTreeModel model;
  final String? title;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'decision-tree',
      attributes: {'role': 'region', 'aria-label': title ?? 'Decision tree'},
      [
        div(classes: 'decision-tree-toolbar', [
          div(classes: 'decision-tree-toolbar-title', [
            const MaterialIcon('account_tree'),
            span([.text(title ?? 'Interactive decision guide')]),
          ]),
          div(classes: 'decision-tree-toolbar-actions', [
            button(
              classes: 'text-button compact-button decision-tree-reset',
              attributes: {'type': 'button', 'hidden': 'hidden'},
              [
                const MaterialIcon('restart_alt'),
                span([.text('Start over')]),
              ],
            ),
            button(
              classes:
                  'outlined-button compact-button decision-tree-toggle-all',
              attributes: {'type': 'button', 'aria-pressed': 'false'},
              [
                const MaterialIcon('visibility'),
                span(classes: 'decision-tree-toggle-label', [
                  .text('Show all paths'),
                ]),
              ],
            ),
          ]),
        ]),
        div(classes: 'decision-tree-steps', [
          for (var i = 0; i < model.steps.length; i++)
            _buildStep(model.steps[i], index: i),
        ]),
        div(
          classes: 'decision-tree-recommendations',
          attributes: {'aria-live': 'polite'},
          [for (final rec in model.recommendations) _buildRecommendation(rec)],
        ),
      ],
    );
  }

  Component _buildStep(DecisionStep step, {required int index}) {
    final isFirst = index == 0;
    return div(
      classes: ['decision-tree-step', if (isFirst) 'is-active'].toClasses,
      attributes: {
        'data-step-id': step.id,
        'data-step-index': '$index',
        if (!isFirst) 'hidden': 'hidden',
      },
      [
        div(classes: 'decision-tree-step-header', [
          span(classes: 'decision-tree-step-badge', [
            .text('Question ${index + 1}'),
          ]),
          h4(classes: 'decision-tree-question no_toc', [
            DashMarkdown(content: step.question, inline: true),
          ]),
        ]),
        if (step.description case final description?)
          div(classes: 'decision-tree-step-description', [
            DashMarkdown(content: description),
          ]),
        if (step.checklist case final checklist? when checklist.isNotEmpty)
          ul(classes: 'decision-tree-checklist', [
            for (final item in checklist)
              li([DashMarkdown(content: item, inline: true)]),
          ]),
        if (step.callout case final callout?) _buildCallout(callout),
        div(
          classes: 'decision-tree-options',
          attributes: {'role': 'group', 'aria-label': step.question},
          [
            for (final option in step.options)
              _buildOption(stepId: step.id, option: option),
          ],
        ),
      ],
    );
  }

  Component _buildOption({
    required String stepId,
    required DecisionOption option,
  }) {
    return button(
      classes: 'decision-tree-option',
      attributes: {
        'type': 'button',
        'aria-pressed': 'false',
        'data-from-step': stepId,
        if (option.nextStep case final nextStep?) 'data-next-step': nextStep,
        if (option.recommendation case final rec?) 'data-recommendation': rec,
      },
      [
        div(classes: 'decision-tree-option-header', [
          if (option.icon case final iconId?)
            MaterialIcon(iconId, classes: const ['decision-tree-option-icon']),
          span(classes: 'decision-tree-option-label', [
            DashMarkdown(content: option.label, inline: true),
          ]),
          const MaterialIcon(
            'arrow_forward',
            classes: ['decision-tree-option-arrow'],
          ),
        ]),
        if (option.subtitle case final subtitle?)
          span(classes: 'decision-tree-option-subtitle', [
            DashMarkdown(content: subtitle, inline: true),
          ]),
      ],
    );
  }

  Component _buildRecommendation(DecisionRecommendation rec) {
    return div(
      classes: 'decision-tree-recommendation',
      attributes: {'data-recommendation-id': rec.id, 'hidden': 'hidden'},
      [
        div(classes: 'decision-tree-recommendation-header', [
          MaterialIcon(
            rec.icon ?? 'recommend',
            classes: const ['decision-tree-recommendation-icon'],
          ),
          div(classes: 'decision-tree-recommendation-titles', [
            span(classes: 'decision-tree-recommendation-eyebrow', [
              .text('Recommended approach'),
            ]),
            h4(classes: 'decision-tree-recommendation-title no_toc', [
              DashMarkdown(content: rec.title, inline: true),
            ]),
          ]),
        ]),
        div(classes: 'decision-tree-recommendation-body', [
          DashMarkdown(content: rec.description),
        ]),
        if (rec.callout case final callout?) _buildCallout(callout),
        if (rec.link case final link?)
          div(classes: 'decision-tree-recommendation-actions', [
            Button(
              href: link,
              content: rec.linkText ?? 'Learn more',
              style: ButtonStyle.filled,
              trailingIcon: 'arrow_forward',
            ),
          ]),
      ],
    );
  }

  Component _buildCallout(DecisionCallout callout) {
    return Component.element(
      tag: 'aside',
      classes: 'alert ${callout.cssClass} decision-tree-callout',
      children: [
        if (callout.title case final title? when title.isNotEmpty)
          div(classes: 'alert-header', [
            if (callout.iconId case final iconId?) MaterialIcon(iconId),
            span([DashMarkdown(content: title, inline: true)]),
          ]),
        div(classes: 'alert-content', [DashMarkdown(content: callout.content)]),
      ],
    );
  }
}

/// Data model parsed from `<DecisionTree>` YAML content.
final class DecisionTreeModel {
  const DecisionTreeModel({required this.steps, required this.recommendations});

  factory DecisionTreeModel.fromMap(Map<Object?, Object?> map) {
    final rawSteps = map['steps'];
    if (rawSteps is! List || rawSteps.isEmpty) {
      throw ArgumentError('DecisionTree requires a non-empty "steps" list.');
    }

    final rawRecommendations = map['recommendations'];
    if (rawRecommendations is! List || rawRecommendations.isEmpty) {
      throw ArgumentError(
        'DecisionTree requires a non-empty "recommendations" list.',
      );
    }

    final steps = rawSteps
        .map((s) => DecisionStep.fromMap(s as Map<Object?, Object?>))
        .toList(growable: false);
    final recommendations = rawRecommendations
        .map((r) => DecisionRecommendation.fromMap(r as Map<Object?, Object?>))
        .toList(growable: false);

    final stepIds = {for (final step in steps) step.id};
    final recIds = {for (final rec in recommendations) rec.id};

    // Validate step option targets at build time so writers get immediate,
    // actionable errors if a step or recommendation ID is mistyped.
    for (final step in steps) {
      for (final option in step.options) {
        if (option.nextStep case final nextStep?
            when !stepIds.contains(nextStep)) {
          throw ArgumentError(
            'DecisionTree option "${option.label}" in step "${step.id}" '
            'references unknown next_step "$nextStep". '
            'Available steps: ${stepIds.join(", ")}.',
          );
        }
        if (option.recommendation case final rec? when !recIds.contains(rec)) {
          throw ArgumentError(
            'DecisionTree option "${option.label}" in step "${step.id}" '
            'references unknown recommendation "$rec". '
            'Available recommendations: ${recIds.join(", ")}.',
          );
        }
      }
    }

    return DecisionTreeModel(steps: steps, recommendations: recommendations);
  }

  final List<DecisionStep> steps;
  final List<DecisionRecommendation> recommendations;
}

/// A single question step in a [DecisionTreeModel].
final class DecisionStep {
  const DecisionStep({
    required this.id,
    required this.question,
    required this.options,
    this.description,
    this.checklist,
    this.callout,
  });

  factory DecisionStep.fromMap(Map<Object?, Object?> map) {
    final id = map['id'] as String?;
    final question = map['question'] as String?;
    final rawOptions = map['options'];

    if (id == null || id.isEmpty) {
      throw ArgumentError('Each DecisionTree step requires an "id".');
    }
    if (question == null || question.isEmpty) {
      throw ArgumentError('DecisionTree step "$id" requires a "question".');
    }
    if (rawOptions is! List || rawOptions.isEmpty) {
      throw ArgumentError(
        'DecisionTree step "$id" requires a non-empty "options" list.',
      );
    }

    final rawChecklist = map['checklist'];
    final checklist = rawChecklist is List
        ? rawChecklist.map((item) => item.toString()).toList(growable: false)
        : null;

    final rawCallout = map['callout'];
    final callout = rawCallout is Map<Object?, Object?>
        ? DecisionCallout.fromMap(rawCallout)
        : null;

    return DecisionStep(
      id: id,
      question: question,
      description: map['description'] as String?,
      checklist: checklist,
      callout: callout,
      options: rawOptions
          .map((o) => DecisionOption.fromMap(o as Map<Object?, Object?>))
          .toList(growable: false),
    );
  }

  final String id;
  final String question;
  final String? description;
  final List<String>? checklist;
  final DecisionCallout? callout;
  final List<DecisionOption> options;
}

/// A selectable option within a [DecisionStep].
final class DecisionOption {
  const DecisionOption({
    required this.label,
    this.subtitle,
    this.icon,
    this.nextStep,
    this.recommendation,
  });

  factory DecisionOption.fromMap(Map<Object?, Object?> map) {
    final label = map['label'] as String?;
    if (label == null || label.isEmpty) {
      throw ArgumentError('Each DecisionTree option requires a "label".');
    }

    final nextStep = map['next_step'] as String?;
    final recommendation = map['recommendation'] as String?;
    if ((nextStep == null) == (recommendation == null)) {
      throw ArgumentError(
        'DecisionTree option "$label" must specify exactly one of '
        '"next_step" or "recommendation".',
      );
    }

    return DecisionOption(
      label: label,
      subtitle: map['subtitle'] as String?,
      icon: map['icon'] as String?,
      nextStep: nextStep,
      recommendation: recommendation,
    );
  }

  final String label;
  final String? subtitle;
  final String? icon;
  final String? nextStep;
  final String? recommendation;
}

/// A final outcome card in a [DecisionTreeModel].
final class DecisionRecommendation {
  const DecisionRecommendation({
    required this.id,
    required this.title,
    required this.description,
    this.icon,
    this.callout,
    this.link,
    this.linkText,
  });

  factory DecisionRecommendation.fromMap(Map<Object?, Object?> map) {
    final id = map['id'] as String?;
    final title = map['title'] as String?;
    final description = map['description'] as String?;

    if (id == null || id.isEmpty) {
      throw ArgumentError('Each DecisionTree recommendation requires an "id".');
    }
    if (title == null || title.isEmpty) {
      throw ArgumentError(
        'DecisionTree recommendation "$id" requires a "title".',
      );
    }
    if (description == null || description.isEmpty) {
      throw ArgumentError(
        'DecisionTree recommendation "$id" requires a "description".',
      );
    }

    final rawCallout = map['callout'];
    final callout = rawCallout is Map<Object?, Object?>
        ? DecisionCallout.fromMap(rawCallout)
        : null;

    return DecisionRecommendation(
      id: id,
      title: title,
      description: description,
      icon: map['icon'] as String?,
      callout: callout,
      link: map['link'] as String?,
      linkText: map['link_text'] as String?,
    );
  }

  final String id;
  final String title;
  final String description;
  final String? icon;
  final DecisionCallout? callout;
  final String? link;
  final String? linkText;
}

/// An optional alert callout attached to a [DecisionStep] or
/// [DecisionRecommendation].
final class DecisionCallout {
  const DecisionCallout({
    required this.type,
    required this.content,
    this.title,
  });

  factory DecisionCallout.fromMap(Map<Object?, Object?> map) {
    final type = (map['type'] as String? ?? 'note').toLowerCase();
    final content = map['content'] as String?;
    if (content == null || content.isEmpty) {
      throw ArgumentError('DecisionTree callout requires "content".');
    }
    return DecisionCallout(
      type: type,
      title: map['title'] as String?,
      content: content,
    );
  }

  final String type;
  final String? title;
  final String content;

  String get cssClass => switch (type) {
    'important' => 'alert-important',
    'warning' || 'experimental' => 'alert-warning',
    'caution' => 'alert-error',
    'tip' || 'recommend' => 'alert-success',
    'secondary' => 'alert-secondary',
    _ => 'alert-info',
  };

  String? get iconId => switch (type) {
    'important' => 'feedback',
    'warning' => 'warning',
    'experimental' => 'construction',
    'caution' => 'error',
    'tip' => 'lightbulb',
    'recommend' => 'bolt',
    'secondary' => null,
    _ => 'info',
  };
}
