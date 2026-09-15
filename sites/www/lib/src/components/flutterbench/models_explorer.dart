// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';
import 'package:universal_web/web.dart' as web;

import 'bench_formatters.dart';
import 'benchmark_scores.dart';
import 'model_detail_view.dart';
import 'model_name_formatter.dart';

/// Two-pane browser for every evaluated model configuration.
///
/// The left rail lists and filters configurations, and the right pane shows
/// the same [ModelDetailView] the leaderboard drawer uses.
@client
class ModelsExplorer extends StatefulComponent {
  const ModelsExplorer({
    required this.evals,
    this.benchmarks = const [],
    super.key,
  });

  final List<Map<String, Object?>> evals;

  /// Per-task results for every eval.
  final List<Map<String, Object?>> benchmarks;

  @override
  State<ModelsExplorer> createState() => _ModelsExplorerState();
}

class _ModelsExplorerState extends State<ModelsExplorer> {
  static const String _modelQueryParameter = 'model';

  String _searchQuery = '';
  String _providerFilter = _allProviders;
  String? _selectedEvalKey;

  static const String _allProviders = 'All companies';

  late final List<BenchmarkRow> _benchmarks = benchmarkRowsFromMaps(
    component.benchmarks,
  );

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      final url = Uri.parse(web.window.location.href);
      _selectedEvalKey = url.queryParameters[_modelQueryParameter];
    }
    // Falls back to the top-ranked configuration so the detail pane is never
    // empty on first paint.
    if (!_evalKeys.contains(_selectedEvalKey)) {
      _selectedEvalKey = _sortedEvals.firstOrNull?['eval_key'] as String?;
    }
  }

  Set<String> get _evalKeys => {
    for (final eval in component.evals) eval['eval_key'] as String,
  };

  List<Map<String, Object?>> get _sortedEvals {
    return [...component.evals]..sort((evalA, evalB) {
      final rewardA = (evalA['mean_reward'] as num?)?.toDouble() ?? 0.0;
      final rewardB = (evalB['mean_reward'] as num?)?.toDouble() ?? 0.0;
      return rewardB.compareTo(rewardA);
    });
  }

  List<String> get _providers {
    final providers = {
      for (final eval in component.evals)
        eval['provider'] as String? ?? 'Community',
    }.toList()..sort();
    return [_allProviders, ...providers];
  }

  List<Map<String, Object?>> get _visibleEvals {
    final query = _searchQuery.trim().toLowerCase();

    return _sortedEvals.where((eval) {
      if (_providerFilter != _allProviders &&
          (eval['provider'] as String? ?? 'Community') != _providerFilter) {
        return false;
      }
      if (query.isEmpty) return true;

      final model = (eval['model_short_name'] as String? ?? '').toLowerCase();
      final agent = (eval['agent_name'] as String? ?? '').toLowerCase();
      return model.contains(query) || agent.contains(query);
    }).toList();
  }

  void _select(String evalKey) {
    setState(() => _selectedEvalKey = evalKey);

    if (!kIsWeb) return;
    // Keeps the selection shareable and survivable across reloads.
    final url = Uri.parse(web.window.location.href);
    web.window.history.replaceState(
      web.window.history.state,
      '',
      url.withQueryParameters({
        ...url.queryParameters,
        _modelQueryParameter: evalKey,
      }).toString(),
    );
  }

  @override
  Component build(BuildContext context) {
    final visible = _visibleEvals;
    final selected = component.evals.firstWhere(
      (eval) => eval['eval_key'] == _selectedEvalKey,
      orElse: () => const {},
    );

    return div(classes: 'models-explorer', [
      _buildSidebar(visible),
      div(classes: 'models-explorer__detail', [
        if (selected.isEmpty)
          const p(classes: 'text-muted', [
            .text('Select a model configuration to see its full results.'),
          ])
        else
          ModelDetailView(
            eval: selected,
            evals: component.evals,
            benchmarks: _benchmarks,
          ),
      ]),
    ]);
  }

  Component _buildSidebar(List<Map<String, Object?>> visible) {
    return aside(
      classes: 'models-explorer__sidebar',
      attributes: const {'aria-label': 'Model configurations'},
      [
        div(classes: 'models-explorer__controls', [
          label(classes: 'models-explorer__field', [
            const span(classes: 'models-explorer__field-label', [
              .text('Company'),
            ]),
            select(
              classes: 'models-explorer__select',
              value: _providerFilter,
              onChange: (values) {
                setState(
                  () => _providerFilter = values.firstOrNull ?? _allProviders,
                );
              },
              [
                for (final provider in _providers)
                  option(value: provider, [.text(provider)]),
              ],
            ),
          ]),
          label(classes: 'models-explorer__field', [
            const span(classes: 'models-explorer__field-label', [
              .text('Search'),
            ]),
            input(
              type: InputType.search,
              classes: 'bench-search-input',
              value: _searchQuery,
              attributes: const {'placeholder': 'Search models...'},
              onInput: (value) {
                setState(() => _searchQuery = value?.toString() ?? '');
              },
            ),
          ]),
        ]),
        const div(classes: 'models-explorer__list-header', [
          span([.text('Model')]),
          span([.text('Score')]),
        ]),
        if (visible.isEmpty)
          const p(classes: 'text-muted models-explorer__empty', [
            .text('No models match the current filters.'),
          ])
        else
          ul(classes: 'models-explorer__list', [
            for (final eval in visible) _buildListItem(eval),
          ]),
      ],
    );
  }

  Component _buildListItem(Map<String, Object?> eval) {
    final evalKey = eval['eval_key'] as String;
    final isSelected = evalKey == _selectedEvalKey;
    final reward = (eval['mean_reward'] as num?)?.toDouble();

    return li([
      button(
        classes: [
          'models-explorer__item',
          if (isSelected) 'selected',
        ].join(' '),
        attributes: {
          'type': 'button',
          'aria-current': '$isSelected',
        },
        onClick: () => _select(evalKey),
        [
          span(classes: 'models-explorer__item-main', [
            span(classes: 'models-explorer__item-name', [
              .text(formatModelName(eval['model_short_name'] as String)),
            ]),
            span(classes: 'models-explorer__item-meta', [
              .text(
                '${eval['agent_name']} · '
                '${eval['provider'] as String? ?? 'Community'}',
              ),
            ]),
          ]),
          span(classes: 'models-explorer__item-score', [
            .text(formatScore(reward)),
          ]),
        ],
      ),
    ]);
  }
}
