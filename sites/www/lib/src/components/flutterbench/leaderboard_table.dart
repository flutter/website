// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:site_shared/util.dart';
import 'package:universal_web/web.dart' as web;

import '../common/drawer.dart';
import '../common/filters.dart';
import 'bench_formatters.dart';
import 'benchmark_scores.dart';
import 'error_state_badge.dart';
import 'model_detail_view.dart';
import 'model_name_formatter.dart';

enum LeaderboardSortColumn {
  model,
  outcomeScore,
  qualityScore,
  dxScore,
  tokens,
  cost,
  overallScore,
}

/// Interactive leaderboard table and filter controls.
///
/// Hydrated on the client via Jaspr's `@client` boundary.
@client
class LeaderboardTable extends StatefulComponent {
  const LeaderboardTable({
    required this.evals,
    this.benchmarks = const [],
    super.key,
  });

  final List<Map<String, Object?>> evals;

  /// Per-task results for every eval, shown in the details drawer.
  final List<Map<String, Object?>> benchmarks;

  @override
  State<LeaderboardTable> createState() => _LeaderboardTableState();
}

class _LeaderboardTableState extends State<LeaderboardTable> {
  LeaderboardSortColumn _sortColumn = LeaderboardSortColumn.overallScore;
  bool _sortAscending = false;
  Map<FilterType, Set<String>> _activeFilters = {};
  String _searchQuery = '';

  /// The eval shown in the details drawer.
  ///
  /// This outlives [_isDrawerOpen] so the drawer keeps
  /// rendering its contents while it slides closed.
  Map<String, Object?>? _drawerEval;
  bool _isDrawerOpen = false;

  late final List<BenchmarkRow> _benchmarks = benchmarkRowsFromMaps(
    component.benchmarks,
  );

  static const String _providerFilterId = 'providers';
  static const String _toolingFilterId = 'toolings';

  List<FilterType> _buildFilters() {
    final providers = <String>{};
    for (final e in component.evals) {
      if (e['provider'] case final String p) {
        providers.add(p);
      } else {
        providers.add('Community');
      }
    }
    final sortedProviders = providers.toList()..sort();

    return [
      FilterType(_providerFilterId, 'Provider', sortedProviders),
      const FilterType(_toolingFilterId, 'Tooling', [
        'With tooling',
        'Without tooling',
      ]),
    ];
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _loadFiltersFromUrl();
    }
  }

  String _paramName(FilterType type) => type.id;

  void _loadFiltersFromUrl() {
    final url = Uri.parse(web.window.location.href);
    final filters = _buildFilters();
    final loaded = <FilterType, Set<String>>{};

    for (final type in filters) {
      final param = url.queryParameters[_paramName(type)];
      if (param != null && param.isNotEmpty) {
        loaded[type] = param.split(',').toSet();
      }
    }
    if (loaded.isNotEmpty) {
      _activeFilters = loaded;
    }
  }

  void _applyFilters(Map<FilterType, Set<String>> filters) {
    if (kIsWeb) {
      final url = Uri.parse(web.window.location.href);
      final newQueryParameters = <String, String>{...url.queryParameters};

      for (final type in _buildFilters()) {
        final paramName = _paramName(type);
        newQueryParameters.remove(paramName);
        if (filters[type] case final options? when options.isNotEmpty) {
          newQueryParameters[paramName] = options.join(',');
        }
      }

      web.window.history.replaceState(
        web.window.history.state,
        '',
        url.withQueryParameters(newQueryParameters).toString(),
      );
    }

    setState(() {
      _activeFilters = filters;
    });
  }

  void _onSort(LeaderboardSortColumn column) {
    setState(() {
      if (_sortColumn == column) {
        _sortAscending = !_sortAscending;
      } else {
        _sortColumn = column;
        _sortAscending = false;
      }
    });
  }

  void _openDrawer(Map<String, Object?> item) {
    setState(() {
      _drawerEval = item;
      _isDrawerOpen = true;
    });
  }

  void _closeDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });
  }

  @override
  Component build(BuildContext context) {
    final filters = _buildFilters();
    final providerType = filters[0];
    final toolingType = filters[1];

    final activeProviders = _activeFilters[providerType] ?? {};
    final activeTooling = _activeFilters[toolingType] ?? {};

    // 1. Filter
    final filtered = component.evals.where((item) {
      if (activeProviders.isNotEmpty) {
        final provider = (item['provider'] as String?) ?? 'Community';
        if (!activeProviders.contains(provider)) {
          return false;
        }
      }

      if (activeTooling.isNotEmpty) {
        final hasTooling = item['has_dart_tooling'] == true;
        final wantsWith = activeTooling.contains('With tooling');
        final wantsWithout = activeTooling.contains('Without tooling');
        if (wantsWith && !wantsWithout && !hasTooling) {
          return false;
        }
        if (wantsWithout && !wantsWith && hasTooling) {
          return false;
        }
      }

      if (_searchQuery.trim().isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final model = ((item['model_name'] as String?) ?? '').toLowerCase();
        final agent = ((item['agent_name'] as String?) ?? '').toLowerCase();
        if (!model.contains(query) && !agent.contains(query)) {
          return false;
        }
      }

      return true;
    }).toList();

    // 2. Sort
    filtered.sort((itemA, itemB) {
      int cmp;
      switch (_sortColumn) {
        case LeaderboardSortColumn.model:
          final ma = (itemA['model_short_name'] as String? ?? '').toLowerCase();
          final mb = (itemB['model_short_name'] as String? ?? '').toLowerCase();
          cmp = ma.compareTo(mb);
        case LeaderboardSortColumn.outcomeScore:
          final oa = (itemA['outcome_score'] as num?)?.toDouble() ?? 0.0;
          final ob = (itemB['outcome_score'] as num?)?.toDouble() ?? 0.0;
          cmp = oa.compareTo(ob);
        case LeaderboardSortColumn.qualityScore:
          final qa = (itemA['quality_score'] as num?)?.toDouble() ?? 0.0;
          final qb = (itemB['quality_score'] as num?)?.toDouble() ?? 0.0;
          cmp = qa.compareTo(qb);
        case LeaderboardSortColumn.dxScore:
          final da = (itemA['dx_score'] as num?)?.toDouble() ?? 0.0;
          final db = (itemB['dx_score'] as num?)?.toDouble() ?? 0.0;
          cmp = da.compareTo(db);
        case LeaderboardSortColumn.tokens:
          final ta =
              ((itemA['input_tokens'] as num?)?.toInt() ?? 0) +
              ((itemA['output_tokens'] as num?)?.toInt() ?? 0);
          final tb =
              ((itemB['input_tokens'] as num?)?.toInt() ?? 0) +
              ((itemB['output_tokens'] as num?)?.toInt() ?? 0);
          cmp = ta.compareTo(tb);
        case LeaderboardSortColumn.cost:
          final ca = (itemA['cost_usd'] as num?)?.toDouble() ?? 0.0;
          final cb = (itemB['cost_usd'] as num?)?.toDouble() ?? 0.0;
          cmp = ca.compareTo(cb);
        case LeaderboardSortColumn.overallScore:
          final ra = (itemA['mean_reward'] as num?)?.toDouble() ?? 0.0;
          final rb = (itemB['mean_reward'] as num?)?.toDouble() ?? 0.0;
          cmp = ra.compareTo(rb);
      }
      return _sortAscending ? cmp : -cmp;
    });

    return div(classes: 'bench-leaderboard-section', [
      // FilterBar
      div(classes: 'bench-filter-bar', [
        FiltersDropdown(
          filters: filters,
          activeFilters: _activeFilters,
          applyFilters: _applyFilters,
        ),

        div(classes: 'filter-group search-input-group', [
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

      // Table
      div(classes: 'bench-table-wrapper', [
        table(classes: 'bench-table', [
          thead([
            tr([
              th(
                classes: 'col-model sortable',
                events: {'click': (_) => _onSort(LeaderboardSortColumn.model)},
                [
                  const .text('Model'),
                  _buildSortIndicator(LeaderboardSortColumn.model),
                ],
              ),
              th(
                classes: 'col-outcome sortable',
                events: {
                  'click': (_) => _onSort(LeaderboardSortColumn.outcomeScore),
                },
                [
                  const .text('Outcome Score'),
                  _buildSortIndicator(LeaderboardSortColumn.outcomeScore),
                ],
              ),
              th(
                classes: 'col-quality sortable',
                events: {
                  'click': (_) => _onSort(LeaderboardSortColumn.qualityScore),
                },
                [
                  const .text('Quality Score'),
                  _buildSortIndicator(LeaderboardSortColumn.qualityScore),
                ],
              ),
              th(
                classes: 'col-dx sortable',
                events: {
                  'click': (_) => _onSort(LeaderboardSortColumn.dxScore),
                },
                [
                  const .text('DX Score'),
                  _buildSortIndicator(LeaderboardSortColumn.dxScore),
                ],
              ),
              th(
                classes: 'col-tokens sortable',
                events: {'click': (_) => _onSort(LeaderboardSortColumn.tokens)},
                [
                  const .text('Token'),
                  _buildSortIndicator(LeaderboardSortColumn.tokens),
                ],
              ),
              th(
                classes: 'col-cost sortable',
                events: {'click': (_) => _onSort(LeaderboardSortColumn.cost)},
                [
                  const .text('Cost'),
                  _buildSortIndicator(LeaderboardSortColumn.cost),
                ],
              ),
              th(
                classes: 'col-overall sortable',
                events: {
                  'click': (_) => _onSort(LeaderboardSortColumn.overallScore),
                },
                [
                  const .text('Overall Score'),
                  _buildSortIndicator(LeaderboardSortColumn.overallScore),
                ],
              ),
            ]),
          ]),
          tbody([
            if (filtered.isEmpty)
              const tr([
                td(
                  attributes: {'colspan': '7'},
                  classes: 'empty-table-message',
                  [.text('No models match the selected filters.')],
                ),
              ])
            else
              for (var i = 0; i < filtered.length; i++)
                _buildTableRow(filtered[i], rank: i + 1),
          ]),
        ]),
      ]),

      _buildDetailsDrawer(),
    ]);
  }

  Component _buildDetailsDrawer() {
    final item = _drawerEval;

    return Drawer(
      id: 'bench-leaderboard-details',
      isOpen: _isDrawerOpen,
      onClose: _closeDrawer,
      classes: 'bench-details-drawer',
      titleVisible: false,
      title: item == null
          ? 'Model details'
          : '${formatModelName(item['model_short_name'] as String)} details',
      [
        if (item != null)
          ModelDetailView(
            eval: item,
            evals: component.evals,
            benchmarks: _benchmarks,
            modelsPageLink: '/ai/flutterbench/models?model=${item['eval_key']}',
          ),
      ],
    );
  }

  Component _buildSortIndicator(LeaderboardSortColumn column) {
    if (_sortColumn != column) {
      return const span(classes: 'sort-indicator inactive', [.text(' ↕')]);
    }
    return span(
      classes: 'sort-indicator active',
      [.text(_sortAscending ? ' ↑' : ' ↓')],
    );
  }

  Component _buildTableRow(Map<String, Object?> item, {required int rank}) {
    final evalKey = item['eval_key'] as String;
    final modelShort = item['model_short_name'] as String;
    final agentName = item['agent_name'] as String;
    final provider = item['provider'] as String? ?? 'Community';

    final outcomeScore = (item['outcome_score'] as num?)?.toDouble();
    final qualityScore = (item['quality_score'] as num?)?.toDouble();
    final dxScore = (item['dx_score'] as num?)?.toDouble();
    final mean = (item['mean_reward'] as num?)?.toDouble() ?? 0.0;
    final min = (item['min_reward'] as num?)?.toDouble() ?? 0.0;
    final max = (item['max_reward'] as num?)?.toDouble() ?? 0.0;
    final cost = (item['cost_usd'] as num?)?.toDouble() ?? 0.0;
    final inTok = (item['input_tokens'] as num?)?.toInt() ?? 0;
    final outTok = (item['output_tokens'] as num?)?.toInt() ?? 0;
    final totalTok = inTok + outTok;
    final nErrors = (item['n_errors'] as num?)?.toInt() ?? 0;
    final nTrials = (item['n_trials'] as num?)?.toInt() ?? 0;
    final isErrored = nErrors > 0 && nTrials == 0;

    final isSelected = _isDrawerOpen && _drawerEval?['eval_key'] == evalKey;

    return tr(
      classes: [
        'bench-row',
        if (isSelected) 'selected',
      ].join(' '),
      attributes: {
        'tabindex': '0',
        'aria-haspopup': 'dialog',
        'aria-expanded': '$isSelected',
      },
      events: {
        'click': (_) => _openDrawer(item),
        'keydown': (event) {
          if (event case web.KeyboardEvent(:final key)
              when key == 'Enter' || key == ' ') {
            event.preventDefault();
            _openDrawer(item);
          }
        },
      },
      [
        td(classes: 'col-model', [
          div(classes: 'model-info-cell', [
            div(classes: 'model-title-row', [
              span(classes: 'rank-pill', [.text('#$rank')]),
              span(
                classes: 'model-name-text',
                [.text(formatModelName(modelShort))],
              ),
            ]),
            span(classes: 'agent-subtext', [.text('$agentName · $provider')]),
          ]),
        ]),
        td(classes: 'col-outcome', [
          _buildScoreBadge(outcomeScore, isErrored),
        ]),
        td(classes: 'col-quality', [
          _buildScoreBadge(qualityScore, isErrored),
        ]),
        td(classes: 'col-dx', [
          _buildScoreBadge(dxScore, isErrored),
        ]),
        td(classes: 'col-tokens', [
          .text(formatTokens(totalTok)),
        ]),
        td(classes: 'col-cost', [
          .text(cost > 0 ? '\$${cost.toStringAsFixed(3)}' : '—'),
        ]),
        td(classes: 'col-overall', [
          if (isErrored)
            const ErrorStateBadge(exceptionType: 'Errored', compact: true)
          else
            div(classes: 'reward-cell', [
              span(
                classes: [
                  'reward-main-score',
                  if (mean >= 0.8)
                    'score-high'
                  else if (mean >= 0.5)
                    'score-mid'
                  else
                    'score-low',
                ].join(' '),
                [.text(mean.toStringAsFixed(2))],
              ),
              if (min != max)
                span(classes: 'reward-range', [
                  .text(
                    ' (${min.toStringAsFixed(2)}–${max.toStringAsFixed(2)})',
                  ),
                ]),
            ]),
        ]),
      ],
    );
  }

  Component _buildScoreBadge(double? score, bool isErrored) {
    if (isErrored || score == null) {
      return const span(classes: 'text-muted', [.text('—')]);
    }
    final scoreClass = score >= 0.8
        ? 'score-high'
        : score >= 0.5
        ? 'score-mid'
        : 'score-low';
    return span(
      classes: 'score-pill $scoreClass',
      [.text(score.toStringAsFixed(2))],
    );
  }
}
