// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/components/common/material_icon.dart';

/// Cards displaying the Three Core Dimensions of FlutterBench evaluation.
final class ThreeDimensionsCards extends StatelessComponent {
  const ThreeDimensionsCards({super.key});

  @override
  Component build(BuildContext context) {
    return const div(classes: 'dimension-cards-grid', [
      div(classes: 'dimension-card', [
        div(classes: 'card-icon-wrap outcome', [
          MaterialIcon('check_circle'),
        ]),
        h4([.text('1. Outcome')]),
        p([
          .text(
            'Evaluates whether the generated code compiles, runs, and '
            'fulfills all functional UI and task requirements correctly.',
          ),
        ]),
        div(classes: 'card-footer-info', [
          span([.text('Build, Tests, Visual, Heuristics')]),
          span(classes: 'badge outcome', [.text('Functional')]),
        ]),
      ]),
      div(classes: 'dimension-card', [
        div(classes: 'card-icon-wrap quality', [
          MaterialIcon('code'),
        ]),
        h4([.text('2. Code Quality')]),
        p([
          .text(
            'Measures code maintainability, static analysis lints, '
            'architectural health, and idiomatic Dart 3 standards.',
          ),
        ]),
        div(classes: 'card-footer-info', [
          span([.text('Lints, DCM, Structure, Patterns')]),
          span(classes: 'badge quality', [.text('Maintainable')]),
        ]),
      ]),
      div(classes: 'dimension-card', [
        div(classes: 'card-icon-wrap dx', [
          MaterialIcon('bolt'),
        ]),
        h4([.text('3. Developer Experience')]),
        p([
          .text(
            'Tracks agent execution friction, tool call accuracy, '
            'error recovery loops, and step efficiency.',
          ),
        ]),
        div(classes: 'card-footer-info', [
          span([.text('Tooling, Trajectory, Recovery')]),
          span(classes: 'badge dx', [.text('Efficiency')]),
        ]),
      ]),
    ]);
  }
}

/// Interactive filterable Grader Matrix showing evaluation graders.
final class GraderMatrix extends StatelessComponent {
  const GraderMatrix({super.key});

  @override
  Component build(BuildContext context) {
    return const div(classes: 'grader-matrix', [
      div(classes: 'matrix-header', [
        div(classes: 'matrix-title-area', [
          h3([.text('Grader Matrix')]),
          p([
            .text(
              'Explore deterministic, LLM-as-a-judge, and '
              'heuristic evaluation graders.',
            ),
          ]),
        ]),
        div(classes: 'matrix-filters', [
          button(
            classes: 'filter-btn active',
            attributes: {'data-filter': 'all'},
            [.text('All Graders')],
          ),
          button(
            classes: 'filter-btn',
            attributes: {'data-filter': 'outcome'},
            [.text('Outcome')],
          ),
          button(
            classes: 'filter-btn',
            attributes: {'data-filter': 'quality'},
            [.text('Quality')],
          ),
          button(
            classes: 'filter-btn',
            attributes: {'data-filter': 'dx'},
            [.text('DX')],
          ),
          button(
            classes: 'filter-btn',
            attributes: {'data-filter': 'deterministic'},
            [.text('Deterministic')],
          ),
          button(
            classes: 'filter-btn',
            attributes: {'data-filter': 'llm'},
            [.text('LLM Judge (BINEVAL)')],
          ),
        ]),
      ]),
      div(classes: 'grader-cards-grid', [
        // Outcome Graders
        div(classes: 'grader-card cat-outcome cat-deterministic', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat outcome', [.text('Outcome')]),
            span(classes: 'grader-badge badge-deterministic', [
              .text('Deterministic'),
            ]),
          ]),
          h4([.text('Build & Run')]),
          p([
            .text(
              'Binary pass/fail checking if code compiles and launches cleanly.',
            ),
          ]),
        ]),
        div(classes: 'grader-card cat-outcome cat-deterministic', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat outcome', [.text('Outcome')]),
            span(classes: 'grader-badge badge-deterministic', [
              .text('Deterministic'),
            ]),
          ]),
          h4([.text('Unit & Widget Testing')]),
          p([
            .text(
              'Executes test suites and scores passing test ratio '
              'across affected code.',
            ),
          ]),
        ]),
        div(classes: 'grader-card cat-outcome cat-llm', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat outcome', [.text('Outcome')]),
            span(classes: 'grader-badge badge-llm', [
              .text('LLM Judge (BINEVAL)'),
            ]),
          ]),
          h4([.text('Visual Validation')]),
          p([
            .text(
              'Compares DevTools screenshot captures against visual '
              'UI expectations.',
            ),
          ]),
        ]),
        div(classes: 'grader-card cat-outcome cat-heuristic', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat outcome', [.text('Outcome')]),
            span(classes: 'grader-badge badge-heuristic', [
              .text('Heuristic'),
            ]),
          ]),
          h4([.text('Task Heuristics')]),
          p([
            .text(
              'Task-specific checks verifying dependency additions, '
              'required config, and files.',
            ),
          ]),
        ]),

        // Quality Graders
        div(classes: 'grader-card cat-quality cat-deterministic', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat quality', [.text('Quality')]),
            span(classes: 'grader-badge badge-deterministic', [
              .text('Deterministic'),
            ]),
          ]),
          h4([.text('Static Analysis')]),
          p([
            .text('Runs '),
            code([.text('dart analyze')]),
            .text(' enforcing strict project lint rules.'),
          ]),
        ]),
        div(classes: 'grader-card cat-quality cat-deterministic', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat quality', [.text('Quality')]),
            span(classes: 'grader-badge badge-deterministic', [
              .text('Deterministic'),
            ]),
          ]),
          h4([.text('Dart Code Metrics (DCM)')]),
          p([
            .text(
              'Detects dead code, widget complexity, undisposed '
              'controllers, and memory leaks.',
            ),
          ]),
        ]),
        div(classes: 'grader-card cat-quality cat-llm', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat quality', [.text('Quality')]),
            span(classes: 'grader-badge badge-llm', [
              .text('LLM Judge (BINEVAL)'),
            ]),
          ]),
          h4([.text('Idiomatic Dart Review')]),
          p([
            .text(
              'Evaluates modern Dart 3 pattern compliance and '
              'adherence to Effective Dart.',
            ),
          ]),
        ]),
        div(classes: 'grader-card cat-quality cat-deterministic', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat quality', [.text('Quality')]),
            span(classes: 'grader-badge badge-deterministic', [
              .text('Deterministic'),
            ]),
          ]),
          h4([.text('Structural Validation')]),
          p([
            .text(
              'Verifies directory structure, naming conventions, '
              'and required file placement.',
            ),
          ]),
        ]),

        // DX Graders
        div(classes: 'grader-card cat-dx cat-deterministic', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat dx', [.text('DX')]),
            span(classes: 'grader-badge badge-deterministic', [
              .text('Deterministic'),
            ]),
          ]),
          h4([.text('Tool Usage Analysis')]),
          p([
            .text(
              'Detects invalid tool calls, incorrect tool selection, '
              'or broken arguments.',
            ),
          ]),
        ]),
        div(classes: 'grader-card cat-dx cat-llm', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat dx', [.text('DX')]),
            span(classes: 'grader-badge badge-llm', [
              .text('LLM Judge (BINEVAL)'),
            ]),
          ]),
          h4([.text('Trajectory & Step Efficiency')]),
          p([
            .text(
              'Checks HITL compliance, retry frequency, and flags '
              'infinite execution loops.',
            ),
          ]),
        ]),
        div(classes: 'grader-card cat-dx cat-llm', [
          div(classes: 'grader-header', [
            span(classes: 'grader-cat dx', [.text('DX')]),
            span(classes: 'grader-badge badge-llm', [
              .text('LLM Judge (BINEVAL)'),
            ]),
          ]),
          h4([.text('Error Recovery')]),
          p([
            .text(
              'Rates how fluidly the agent adapts to compiler, '
              'analysis, and test errors.',
            ),
          ]),
        ]),
      ]),
    ]);
  }
}

/// Comparison cards for Capability (pass@k) vs Consistency (pass^k).
final class ReliabilityCards extends StatelessComponent {
  const ReliabilityCards({super.key});

  @override
  Component build(BuildContext context) {
    return const div(classes: 'reliability-comparison-grid', [
      div(classes: 'reliability-card', [
        div(classes: 'reliability-header', [
          span(classes: 'tag', [.text('Ceiling Metric')]),
          span(classes: 'math-pill', [.text('pass@k')]),
        ]),
        h4([.text('Capability')]),
        p([
          .text('The probability that an agent succeeds '),
          em([.text('at least once')]),
          .text(' across '),
          strong([.text('k')]),
          .text(
            ' attempts. Shows what the model can achieve under ideal '
            'sample runs.',
          ),
        ]),
      ]),
      div(classes: 'reliability-card north-star', [
        div(classes: 'reliability-header', [
          span(classes: 'tag', [
            MaterialIcon('star'),
            .text('Our North Star'),
          ]),
          span(classes: 'math-pill', [.text('pass^k')]),
        ]),
        h4([.text('Consistency')]),
        p([
          .text('The probability that an agent succeeds '),
          em([.text('every single time')]),
          .text(' across all '),
          strong([.text('k')]),
          .text(
            ' attempts. Solves unreliability friction for '
            'real developer workflows.',
          ),
        ]),
      ]),
    ]);
  }
}

/// Interactive score interpretation and engineering triage matrix.
final class ScoreTriage extends StatelessComponent {
  const ScoreTriage({super.key});

  @override
  Component build(BuildContext context) {
    return const div(classes: 'score-triage', [
      div(classes: 'triage-header', [
        h3([.text('Score Triage & Action Matrix')]),
        p([
          .text(
            'Select a score range to view its criteria and immediate '
            'engineering triage actions.',
          ),
        ]),
      ]),
      div(classes: 'triage-tiers-grid', [
        button(
          classes: 'triage-tier-btn tier-perfect active',
          attributes: {'data-tier': 'perfect'},
          [
            div(classes: 'tier-score', [.text('1.00')]),
            div(classes: 'tier-name', [.text('Perfect Success')]),
          ],
        ),
        button(
          classes: 'triage-tier-btn tier-functional',
          attributes: {'data-tier': 'functional'},
          [
            div(classes: 'tier-score', [.text('0.75 – 0.99')]),
            div(classes: 'tier-name', [.text('Minor Flaws')]),
          ],
        ),
        button(
          classes: 'triage-tier-btn tier-partial',
          attributes: {'data-tier': 'partial'},
          [
            div(classes: 'tier-score', [.text('0.50 – 0.74')]),
            div(classes: 'tier-name', [.text('Partial Success')]),
          ],
        ),
        button(
          classes: 'triage-tier-btn tier-poor',
          attributes: {'data-tier': 'poor'},
          [
            div(classes: 'tier-score', [.text('0.25 – 0.49')]),
            div(classes: 'tier-name', [.text('Poor Execution')]),
          ],
        ),
        button(
          classes: 'triage-tier-btn tier-failure',
          attributes: {'data-tier': 'failure'},
          [
            div(classes: 'tier-score', [.text('0.00')]),
            div(classes: 'tier-name', [.text('Total Failure')]),
          ],
        ),
      ]),
      div(classes: 'triage-detail-card', [
        // Tier 1: Perfect
        div(
          classes: 'triage-panel active',
          attributes: {'data-tier': 'perfect'},
          [
            div(classes: 'panel-heading', [
              h4([.text('Score 1.00 — Perfect Success')]),
              span(classes: 'panel-badge', [.text('Criteria & Triage')]),
            ]),
            p(classes: 'criteria-text', [
              .text(
                'Code compiles, runs, and passes all unit and widget tests. '
                'Zero analyzer or DCM warnings. Idiomatic Dart 3 and '
                'flawless DX.',
              ),
            ]),
            div(classes: 'actions-section', [
              div(classes: 'actions-label', [
                .text('Engineering Triage Actions:'),
              ]),
              ul([
                li([
                  strong([.text('Telemetry check: ')]),
                  .text(
                    'Validate whether all expected tools were utilized.',
                  ),
                ]),
                li([
                  strong([.text('Skip optimization: ')]),
                  .text(
                    'If expected tools were skipped successfully, '
                    're-evaluate if the tool is redundant.',
                  ),
                ]),
                li([
                  strong([.text('Token burn review: ')]),
                  .text(
                    'If token consumption was high, optimize prompt '
                    'context and create fast-path shortcut tools.',
                  ),
                ]),
              ]),
            ]),
          ],
        ),

        // Tier 2: Functional / Minor Flaws
        div(
          classes: 'triage-panel',
          attributes: {'data-tier': 'functional'},
          [
            div(classes: 'panel-heading', [
              h4([.text('Score 0.75 – 0.99 — Minor Flaws')]),
              span(classes: 'panel-badge', [.text('Criteria & Triage')]),
            ]),
            p(classes: 'criteria-text', [
              .text(
                'Code works and functional tests pass, but exhibits minor '
                'lint warnings, slightly unidiomatic patterns, or '
                'minor DX friction.',
              ),
            ]),
            div(classes: 'actions-section', [
              div(classes: 'actions-label', [
                .text('Engineering Triage Actions:'),
              ]),
              ul([
                li([
                  strong([.text('Prompt tuning: ')]),
                  .text(
                    'Tune skill prompt instructions for better Dart 3 '
                    'style enforcement.',
                  ),
                ]),
                li([
                  strong([.text('Schema refinement: ')]),
                  .text(
                    'Refine tool parameter schemas and validation logic '
                    'to prevent minor parameter retry hiccups.',
                  ),
                ]),
                li([
                  strong([.text('Model collaboration: ')]),
                  .text(
                    'Collaborate with model team to polish code '
                    'generation formatting.',
                  ),
                ]),
              ]),
            ]),
          ],
        ),

        // Tier 3: Partial Success
        div(
          classes: 'triage-panel',
          attributes: {'data-tier': 'partial'},
          [
            div(classes: 'panel-heading', [
              h4([.text('Score 0.50 – 0.74 — Partial Success')]),
              span(classes: 'panel-badge', [.text('Criteria & Triage')]),
            ]),
            p(classes: 'criteria-text', [
              .text(
                'Core requirements work but some widget or unit tests fail, '
                'lint warnings are significant, or the agent entered '
                'noticeable recovery loops.',
              ),
            ]),
            div(classes: 'actions-section', [
              div(classes: 'actions-label', [
                .text('Engineering Triage Actions:'),
              ]),
              ul([
                li([
                  strong([.text('Assertion triage: ')]),
                  .text('Investigate specific test assertion failures.'),
                ]),
                li([
                  strong([.text('Context gap analysis: ')]),
                  .text(
                    'Analyze whether the agent lacked key framework '
                    'or package context.',
                  ),
                ]),
                li([
                  strong([.text('Diagnostic feedback: ')]),
                  .text(
                    'Refine compiler diagnostic feedback to help '
                    'the agent self-correct faster.',
                  ),
                ]),
              ]),
            ]),
          ],
        ),

        // Tier 4: Poor Execution
        div(
          classes: 'triage-panel',
          attributes: {'data-tier': 'poor'},
          [
            div(classes: 'panel-heading', [
              h4([.text('Score 0.25 – 0.49 — Poor Implementation')]),
              span(classes: 'panel-badge', [.text('Criteria & Triage')]),
            ]),
            p(classes: 'criteria-text', [
              .text(
                'Fails to compile, ignores constraints, or encountered '
                'severe developer experience breakdown during execution.',
              ),
            ]),
            div(classes: 'actions-section', [
              div(classes: 'actions-label', [
                .text('Engineering Triage Actions:'),
              ]),
              ul([
                li([
                  strong([.text('Tool discoverability: ')]),
                  .text(
                    'If expected tools were ignored, fix tool '
                    'discoverability, frontmatter, and prompt instructions.',
                  ),
                ]),
                li([
                  strong([.text('Tool output clarity: ')]),
                  .text(
                    'If tools were used but failed, improve helper '
                    'tool output clarity and error messaging.',
                  ),
                ]),
                li([
                  strong([.text('Loop prevention: ')]),
                  .text(
                    'If token burn was high due to endless fix loops, '
                    'improve compiler errors for single-step healing.',
                  ),
                ]),
              ]),
            ]),
          ],
        ),

        // Tier 5: Total Failure
        div(
          classes: 'triage-panel',
          attributes: {'data-tier': 'failure'},
          [
            div(classes: 'panel-heading', [
              h4([.text('Score 0.00 — Total Failure')]),
              span(classes: 'panel-badge', [.text('Criteria & Triage')]),
            ]),
            p(classes: 'criteria-text', [
              .text(
                'No working code produced, severe runtime crash, or '
                'agent caught in an infinite loop.',
              ),
            ]),
            div(classes: 'actions-section', [
              div(classes: 'actions-label', [
                .text('Engineering Triage Actions:'),
              ]),
              ul([
                li([
                  strong([.text('Human root-cause audit: ')]),
                  .text(
                    'Engineers inspect reasoning traces, plan adherence, '
                    'and test harness logs.',
                  ),
                ]),
                li([
                  strong([.text('Behavior categorization: ')]),
                  .text(
                    'Identify premature surrender versus infinite '
                    'loop traps.',
                  ),
                ]),
                li([
                  strong([.text('Constraint refinement: ')]),
                  .text(
                    'Update benchmark task prompt constraints and '
                    'bounding parameters.',
                  ),
                ]),
              ]),
            ]),
          ],
        ),
      ]),
    ]);
  }
}
