// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'flutterbench_content.dart';

class FlutterBenchJobDataMapper extends ClassMapperBase<FlutterBenchJobData> {
  FlutterBenchJobDataMapper._();

  static FlutterBenchJobDataMapper? _instance;
  static FlutterBenchJobDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlutterBenchJobDataMapper._());
      FlutterBenchEvalItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchJobData';

  static String _$id(FlutterBenchJobData v) => v.id;
  static const Field<FlutterBenchJobData, String> _f$id = Field('id', _$id);
  static String _$startedAt(FlutterBenchJobData v) => v.startedAt;
  static const Field<FlutterBenchJobData, String> _f$startedAt = Field(
    'startedAt',
    _$startedAt,
    key: r'started_at',
  );
  static String _$finishedAt(FlutterBenchJobData v) => v.finishedAt;
  static const Field<FlutterBenchJobData, String> _f$finishedAt = Field(
    'finishedAt',
    _$finishedAt,
    key: r'finished_at',
  );
  static int _$nTotalTrials(FlutterBenchJobData v) => v.nTotalTrials;
  static const Field<FlutterBenchJobData, int> _f$nTotalTrials = Field(
    'nTotalTrials',
    _$nTotalTrials,
    key: r'n_total_trials',
  );
  static int _$nCompletedTrials(FlutterBenchJobData v) => v.nCompletedTrials;
  static const Field<FlutterBenchJobData, int> _f$nCompletedTrials = Field(
    'nCompletedTrials',
    _$nCompletedTrials,
    key: r'n_completed_trials',
  );
  static int _$nErroredTrials(FlutterBenchJobData v) => v.nErroredTrials;
  static const Field<FlutterBenchJobData, int> _f$nErroredTrials = Field(
    'nErroredTrials',
    _$nErroredTrials,
    key: r'n_errored_trials',
  );
  static double _$costUsd(FlutterBenchJobData v) => v.costUsd;
  static const Field<FlutterBenchJobData, double> _f$costUsd = Field(
    'costUsd',
    _$costUsd,
    key: r'cost_usd',
  );
  static int _$nInputTokens(FlutterBenchJobData v) => v.nInputTokens;
  static const Field<FlutterBenchJobData, int> _f$nInputTokens = Field(
    'nInputTokens',
    _$nInputTokens,
    key: r'n_input_tokens',
  );
  static int _$nCacheTokens(FlutterBenchJobData v) => v.nCacheTokens;
  static const Field<FlutterBenchJobData, int> _f$nCacheTokens = Field(
    'nCacheTokens',
    _$nCacheTokens,
    key: r'n_cache_tokens',
  );
  static int _$nOutputTokens(FlutterBenchJobData v) => v.nOutputTokens;
  static const Field<FlutterBenchJobData, int> _f$nOutputTokens = Field(
    'nOutputTokens',
    _$nOutputTokens,
    key: r'n_output_tokens',
  );
  static String _$topModelName(FlutterBenchJobData v) => v.topModelName;
  static const Field<FlutterBenchJobData, String> _f$topModelName = Field(
    'topModelName',
    _$topModelName,
    key: r'top_model_name',
  );
  static double _$topModelReward(FlutterBenchJobData v) => v.topModelReward;
  static const Field<FlutterBenchJobData, double> _f$topModelReward = Field(
    'topModelReward',
    _$topModelReward,
    key: r'top_model_reward',
  );
  static double _$overallAverageReward(FlutterBenchJobData v) =>
      v.overallAverageReward;
  static const Field<FlutterBenchJobData, double> _f$overallAverageReward =
      Field(
        'overallAverageReward',
        _$overallAverageReward,
        key: r'overall_average_reward',
      );
  static List<FlutterBenchEvalItem> _$evals(FlutterBenchJobData v) => v.evals;
  static const Field<FlutterBenchJobData, List<FlutterBenchEvalItem>> _f$evals =
      Field('evals', _$evals);

  @override
  final MappableFields<FlutterBenchJobData> fields = const {
    #id: _f$id,
    #startedAt: _f$startedAt,
    #finishedAt: _f$finishedAt,
    #nTotalTrials: _f$nTotalTrials,
    #nCompletedTrials: _f$nCompletedTrials,
    #nErroredTrials: _f$nErroredTrials,
    #costUsd: _f$costUsd,
    #nInputTokens: _f$nInputTokens,
    #nCacheTokens: _f$nCacheTokens,
    #nOutputTokens: _f$nOutputTokens,
    #topModelName: _f$topModelName,
    #topModelReward: _f$topModelReward,
    #overallAverageReward: _f$overallAverageReward,
    #evals: _f$evals,
  };

  static FlutterBenchJobData _instantiate(DecodingData data) {
    return FlutterBenchJobData(
      id: data.dec(_f$id),
      startedAt: data.dec(_f$startedAt),
      finishedAt: data.dec(_f$finishedAt),
      nTotalTrials: data.dec(_f$nTotalTrials),
      nCompletedTrials: data.dec(_f$nCompletedTrials),
      nErroredTrials: data.dec(_f$nErroredTrials),
      costUsd: data.dec(_f$costUsd),
      nInputTokens: data.dec(_f$nInputTokens),
      nCacheTokens: data.dec(_f$nCacheTokens),
      nOutputTokens: data.dec(_f$nOutputTokens),
      topModelName: data.dec(_f$topModelName),
      topModelReward: data.dec(_f$topModelReward),
      overallAverageReward: data.dec(_f$overallAverageReward),
      evals: data.dec(_f$evals),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchJobData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchJobData>(map);
  }

  static FlutterBenchJobData fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchJobData>(json);
  }
}

mixin FlutterBenchJobDataMappable {
  String toJson() {
    return FlutterBenchJobDataMapper.ensureInitialized()
        .encodeJson<FlutterBenchJobData>(this as FlutterBenchJobData);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchJobDataMapper.ensureInitialized()
        .encodeMap<FlutterBenchJobData>(this as FlutterBenchJobData);
  }

  FlutterBenchJobDataCopyWith<
    FlutterBenchJobData,
    FlutterBenchJobData,
    FlutterBenchJobData
  >
  get copyWith =>
      _FlutterBenchJobDataCopyWithImpl<
        FlutterBenchJobData,
        FlutterBenchJobData
      >(this as FlutterBenchJobData, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchJobDataMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchJobData,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchJobDataMapper.ensureInitialized().equalsValue(
      this as FlutterBenchJobData,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchJobDataMapper.ensureInitialized().hashValue(
      this as FlutterBenchJobData,
    );
  }
}

extension FlutterBenchJobDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchJobData, $Out> {
  FlutterBenchJobDataCopyWith<$R, FlutterBenchJobData, $Out>
  get $asFlutterBenchJobData => $base.as(
    (v, t, t2) => _FlutterBenchJobDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchJobDataCopyWith<
  $R,
  $In extends FlutterBenchJobData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    FlutterBenchEvalItem,
    FlutterBenchEvalItemCopyWith<$R, FlutterBenchEvalItem, FlutterBenchEvalItem>
  >
  get evals;
  $R call({
    String? id,
    String? startedAt,
    String? finishedAt,
    int? nTotalTrials,
    int? nCompletedTrials,
    int? nErroredTrials,
    double? costUsd,
    int? nInputTokens,
    int? nCacheTokens,
    int? nOutputTokens,
    String? topModelName,
    double? topModelReward,
    double? overallAverageReward,
    List<FlutterBenchEvalItem>? evals,
  });
  FlutterBenchJobDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchJobDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchJobData, $Out>
    implements FlutterBenchJobDataCopyWith<$R, FlutterBenchJobData, $Out> {
  _FlutterBenchJobDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchJobData> $mapper =
      FlutterBenchJobDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    FlutterBenchEvalItem,
    FlutterBenchEvalItemCopyWith<$R, FlutterBenchEvalItem, FlutterBenchEvalItem>
  >
  get evals => ListCopyWith(
    $value.evals,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(evals: v),
  );
  @override
  $R call({
    String? id,
    String? startedAt,
    String? finishedAt,
    int? nTotalTrials,
    int? nCompletedTrials,
    int? nErroredTrials,
    double? costUsd,
    int? nInputTokens,
    int? nCacheTokens,
    int? nOutputTokens,
    String? topModelName,
    double? topModelReward,
    double? overallAverageReward,
    List<FlutterBenchEvalItem>? evals,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (startedAt != null) #startedAt: startedAt,
      if (finishedAt != null) #finishedAt: finishedAt,
      if (nTotalTrials != null) #nTotalTrials: nTotalTrials,
      if (nCompletedTrials != null) #nCompletedTrials: nCompletedTrials,
      if (nErroredTrials != null) #nErroredTrials: nErroredTrials,
      if (costUsd != null) #costUsd: costUsd,
      if (nInputTokens != null) #nInputTokens: nInputTokens,
      if (nCacheTokens != null) #nCacheTokens: nCacheTokens,
      if (nOutputTokens != null) #nOutputTokens: nOutputTokens,
      if (topModelName != null) #topModelName: topModelName,
      if (topModelReward != null) #topModelReward: topModelReward,
      if (overallAverageReward != null)
        #overallAverageReward: overallAverageReward,
      if (evals != null) #evals: evals,
    }),
  );
  @override
  FlutterBenchJobData $make(CopyWithData data) => FlutterBenchJobData(
    id: data.get(#id, or: $value.id),
    startedAt: data.get(#startedAt, or: $value.startedAt),
    finishedAt: data.get(#finishedAt, or: $value.finishedAt),
    nTotalTrials: data.get(#nTotalTrials, or: $value.nTotalTrials),
    nCompletedTrials: data.get(#nCompletedTrials, or: $value.nCompletedTrials),
    nErroredTrials: data.get(#nErroredTrials, or: $value.nErroredTrials),
    costUsd: data.get(#costUsd, or: $value.costUsd),
    nInputTokens: data.get(#nInputTokens, or: $value.nInputTokens),
    nCacheTokens: data.get(#nCacheTokens, or: $value.nCacheTokens),
    nOutputTokens: data.get(#nOutputTokens, or: $value.nOutputTokens),
    topModelName: data.get(#topModelName, or: $value.topModelName),
    topModelReward: data.get(#topModelReward, or: $value.topModelReward),
    overallAverageReward: data.get(
      #overallAverageReward,
      or: $value.overallAverageReward,
    ),
    evals: data.get(#evals, or: $value.evals),
  );

  @override
  FlutterBenchJobDataCopyWith<$R2, FlutterBenchJobData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchJobDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlutterBenchEvalItemMapper extends ClassMapperBase<FlutterBenchEvalItem> {
  FlutterBenchEvalItemMapper._();

  static FlutterBenchEvalItemMapper? _instance;
  static FlutterBenchEvalItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlutterBenchEvalItemMapper._());
      FlutterBenchCujSummaryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchEvalItem';

  static String _$evalKey(FlutterBenchEvalItem v) => v.evalKey;
  static const Field<FlutterBenchEvalItem, String> _f$evalKey = Field(
    'evalKey',
    _$evalKey,
    key: r'eval_key',
  );
  static String _$agentName(FlutterBenchEvalItem v) => v.agentName;
  static const Field<FlutterBenchEvalItem, String> _f$agentName = Field(
    'agentName',
    _$agentName,
    key: r'agent_name',
  );
  static String _$modelName(FlutterBenchEvalItem v) => v.modelName;
  static const Field<FlutterBenchEvalItem, String> _f$modelName = Field(
    'modelName',
    _$modelName,
    key: r'model_name',
  );
  static String _$modelShortName(FlutterBenchEvalItem v) => v.modelShortName;
  static const Field<FlutterBenchEvalItem, String> _f$modelShortName = Field(
    'modelShortName',
    _$modelShortName,
    key: r'model_short_name',
  );
  static String _$provider(FlutterBenchEvalItem v) => v.provider;
  static const Field<FlutterBenchEvalItem, String> _f$provider = Field(
    'provider',
    _$provider,
  );
  static String _$variant(FlutterBenchEvalItem v) => v.variant;
  static const Field<FlutterBenchEvalItem, String> _f$variant = Field(
    'variant',
    _$variant,
  );
  static int _$nTrials(FlutterBenchEvalItem v) => v.nTrials;
  static const Field<FlutterBenchEvalItem, int> _f$nTrials = Field(
    'nTrials',
    _$nTrials,
    key: r'n_trials',
  );
  static int _$nErrors(FlutterBenchEvalItem v) => v.nErrors;
  static const Field<FlutterBenchEvalItem, int> _f$nErrors = Field(
    'nErrors',
    _$nErrors,
    key: r'n_errors',
  );
  static double _$meanReward(FlutterBenchEvalItem v) => v.meanReward;
  static const Field<FlutterBenchEvalItem, double> _f$meanReward = Field(
    'meanReward',
    _$meanReward,
    key: r'mean_reward',
  );
  static double _$minReward(FlutterBenchEvalItem v) => v.minReward;
  static const Field<FlutterBenchEvalItem, double> _f$minReward = Field(
    'minReward',
    _$minReward,
    key: r'min_reward',
  );
  static double _$maxReward(FlutterBenchEvalItem v) => v.maxReward;
  static const Field<FlutterBenchEvalItem, double> _f$maxReward = Field(
    'maxReward',
    _$maxReward,
    key: r'max_reward',
  );
  static double _$medianReward(FlutterBenchEvalItem v) => v.medianReward;
  static const Field<FlutterBenchEvalItem, double> _f$medianReward = Field(
    'medianReward',
    _$medianReward,
    key: r'median_reward',
  );
  static double _$passAt1(FlutterBenchEvalItem v) => v.passAt1;
  static const Field<FlutterBenchEvalItem, double> _f$passAt1 = Field(
    'passAt1',
    _$passAt1,
    key: r'pass_at_1',
  );
  static double _$costUsd(FlutterBenchEvalItem v) => v.costUsd;
  static const Field<FlutterBenchEvalItem, double> _f$costUsd = Field(
    'costUsd',
    _$costUsd,
    key: r'cost_usd',
  );
  static int _$inputTokens(FlutterBenchEvalItem v) => v.inputTokens;
  static const Field<FlutterBenchEvalItem, int> _f$inputTokens = Field(
    'inputTokens',
    _$inputTokens,
    key: r'input_tokens',
  );
  static int _$outputTokens(FlutterBenchEvalItem v) => v.outputTokens;
  static const Field<FlutterBenchEvalItem, int> _f$outputTokens = Field(
    'outputTokens',
    _$outputTokens,
    key: r'output_tokens',
  );
  static bool _$hasDartTooling(FlutterBenchEvalItem v) => v.hasDartTooling;
  static const Field<FlutterBenchEvalItem, bool> _f$hasDartTooling = Field(
    'hasDartTooling',
    _$hasDartTooling,
    key: r'has_dart_tooling',
  );
  static double? _$outcomeScore(FlutterBenchEvalItem v) => v.outcomeScore;
  static const Field<FlutterBenchEvalItem, double> _f$outcomeScore = Field(
    'outcomeScore',
    _$outcomeScore,
    key: r'outcome_score',
    opt: true,
  );
  static double? _$qualityScore(FlutterBenchEvalItem v) => v.qualityScore;
  static const Field<FlutterBenchEvalItem, double> _f$qualityScore = Field(
    'qualityScore',
    _$qualityScore,
    key: r'quality_score',
    opt: true,
  );
  static double? _$dxScore(FlutterBenchEvalItem v) => v.dxScore;
  static const Field<FlutterBenchEvalItem, double> _f$dxScore = Field(
    'dxScore',
    _$dxScore,
    key: r'dx_score',
    opt: true,
  );
  static List<FlutterBenchCujSummary> _$bestCujs(FlutterBenchEvalItem v) =>
      v.bestCujs;
  static const Field<FlutterBenchEvalItem, List<FlutterBenchCujSummary>>
  _f$bestCujs = Field(
    'bestCujs',
    _$bestCujs,
    key: r'best_cujs',
    opt: true,
    def: const [],
  );
  static List<FlutterBenchCujSummary> _$worstCujs(FlutterBenchEvalItem v) =>
      v.worstCujs;
  static const Field<FlutterBenchEvalItem, List<FlutterBenchCujSummary>>
  _f$worstCujs = Field(
    'worstCujs',
    _$worstCujs,
    key: r'worst_cujs',
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<FlutterBenchEvalItem> fields = const {
    #evalKey: _f$evalKey,
    #agentName: _f$agentName,
    #modelName: _f$modelName,
    #modelShortName: _f$modelShortName,
    #provider: _f$provider,
    #variant: _f$variant,
    #nTrials: _f$nTrials,
    #nErrors: _f$nErrors,
    #meanReward: _f$meanReward,
    #minReward: _f$minReward,
    #maxReward: _f$maxReward,
    #medianReward: _f$medianReward,
    #passAt1: _f$passAt1,
    #costUsd: _f$costUsd,
    #inputTokens: _f$inputTokens,
    #outputTokens: _f$outputTokens,
    #hasDartTooling: _f$hasDartTooling,
    #outcomeScore: _f$outcomeScore,
    #qualityScore: _f$qualityScore,
    #dxScore: _f$dxScore,
    #bestCujs: _f$bestCujs,
    #worstCujs: _f$worstCujs,
  };

  static FlutterBenchEvalItem _instantiate(DecodingData data) {
    return FlutterBenchEvalItem(
      evalKey: data.dec(_f$evalKey),
      agentName: data.dec(_f$agentName),
      modelName: data.dec(_f$modelName),
      modelShortName: data.dec(_f$modelShortName),
      provider: data.dec(_f$provider),
      variant: data.dec(_f$variant),
      nTrials: data.dec(_f$nTrials),
      nErrors: data.dec(_f$nErrors),
      meanReward: data.dec(_f$meanReward),
      minReward: data.dec(_f$minReward),
      maxReward: data.dec(_f$maxReward),
      medianReward: data.dec(_f$medianReward),
      passAt1: data.dec(_f$passAt1),
      costUsd: data.dec(_f$costUsd),
      inputTokens: data.dec(_f$inputTokens),
      outputTokens: data.dec(_f$outputTokens),
      hasDartTooling: data.dec(_f$hasDartTooling),
      outcomeScore: data.dec(_f$outcomeScore),
      qualityScore: data.dec(_f$qualityScore),
      dxScore: data.dec(_f$dxScore),
      bestCujs: data.dec(_f$bestCujs),
      worstCujs: data.dec(_f$worstCujs),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchEvalItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchEvalItem>(map);
  }

  static FlutterBenchEvalItem fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchEvalItem>(json);
  }
}

mixin FlutterBenchEvalItemMappable {
  String toJson() {
    return FlutterBenchEvalItemMapper.ensureInitialized()
        .encodeJson<FlutterBenchEvalItem>(this as FlutterBenchEvalItem);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchEvalItemMapper.ensureInitialized()
        .encodeMap<FlutterBenchEvalItem>(this as FlutterBenchEvalItem);
  }

  FlutterBenchEvalItemCopyWith<
    FlutterBenchEvalItem,
    FlutterBenchEvalItem,
    FlutterBenchEvalItem
  >
  get copyWith =>
      _FlutterBenchEvalItemCopyWithImpl<
        FlutterBenchEvalItem,
        FlutterBenchEvalItem
      >(this as FlutterBenchEvalItem, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchEvalItemMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchEvalItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchEvalItemMapper.ensureInitialized().equalsValue(
      this as FlutterBenchEvalItem,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchEvalItemMapper.ensureInitialized().hashValue(
      this as FlutterBenchEvalItem,
    );
  }
}

extension FlutterBenchEvalItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchEvalItem, $Out> {
  FlutterBenchEvalItemCopyWith<$R, FlutterBenchEvalItem, $Out>
  get $asFlutterBenchEvalItem => $base.as(
    (v, t, t2) => _FlutterBenchEvalItemCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchEvalItemCopyWith<
  $R,
  $In extends FlutterBenchEvalItem,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    FlutterBenchCujSummary,
    FlutterBenchCujSummaryCopyWith<
      $R,
      FlutterBenchCujSummary,
      FlutterBenchCujSummary
    >
  >
  get bestCujs;
  ListCopyWith<
    $R,
    FlutterBenchCujSummary,
    FlutterBenchCujSummaryCopyWith<
      $R,
      FlutterBenchCujSummary,
      FlutterBenchCujSummary
    >
  >
  get worstCujs;
  $R call({
    String? evalKey,
    String? agentName,
    String? modelName,
    String? modelShortName,
    String? provider,
    String? variant,
    int? nTrials,
    int? nErrors,
    double? meanReward,
    double? minReward,
    double? maxReward,
    double? medianReward,
    double? passAt1,
    double? costUsd,
    int? inputTokens,
    int? outputTokens,
    bool? hasDartTooling,
    double? outcomeScore,
    double? qualityScore,
    double? dxScore,
    List<FlutterBenchCujSummary>? bestCujs,
    List<FlutterBenchCujSummary>? worstCujs,
  });
  FlutterBenchEvalItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchEvalItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchEvalItem, $Out>
    implements FlutterBenchEvalItemCopyWith<$R, FlutterBenchEvalItem, $Out> {
  _FlutterBenchEvalItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchEvalItem> $mapper =
      FlutterBenchEvalItemMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    FlutterBenchCujSummary,
    FlutterBenchCujSummaryCopyWith<
      $R,
      FlutterBenchCujSummary,
      FlutterBenchCujSummary
    >
  >
  get bestCujs => ListCopyWith(
    $value.bestCujs,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(bestCujs: v),
  );
  @override
  ListCopyWith<
    $R,
    FlutterBenchCujSummary,
    FlutterBenchCujSummaryCopyWith<
      $R,
      FlutterBenchCujSummary,
      FlutterBenchCujSummary
    >
  >
  get worstCujs => ListCopyWith(
    $value.worstCujs,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(worstCujs: v),
  );
  @override
  $R call({
    String? evalKey,
    String? agentName,
    String? modelName,
    String? modelShortName,
    String? provider,
    String? variant,
    int? nTrials,
    int? nErrors,
    double? meanReward,
    double? minReward,
    double? maxReward,
    double? medianReward,
    double? passAt1,
    double? costUsd,
    int? inputTokens,
    int? outputTokens,
    bool? hasDartTooling,
    Object? outcomeScore = $none,
    Object? qualityScore = $none,
    Object? dxScore = $none,
    List<FlutterBenchCujSummary>? bestCujs,
    List<FlutterBenchCujSummary>? worstCujs,
  }) => $apply(
    FieldCopyWithData({
      if (evalKey != null) #evalKey: evalKey,
      if (agentName != null) #agentName: agentName,
      if (modelName != null) #modelName: modelName,
      if (modelShortName != null) #modelShortName: modelShortName,
      if (provider != null) #provider: provider,
      if (variant != null) #variant: variant,
      if (nTrials != null) #nTrials: nTrials,
      if (nErrors != null) #nErrors: nErrors,
      if (meanReward != null) #meanReward: meanReward,
      if (minReward != null) #minReward: minReward,
      if (maxReward != null) #maxReward: maxReward,
      if (medianReward != null) #medianReward: medianReward,
      if (passAt1 != null) #passAt1: passAt1,
      if (costUsd != null) #costUsd: costUsd,
      if (inputTokens != null) #inputTokens: inputTokens,
      if (outputTokens != null) #outputTokens: outputTokens,
      if (hasDartTooling != null) #hasDartTooling: hasDartTooling,
      if (outcomeScore != $none) #outcomeScore: outcomeScore,
      if (qualityScore != $none) #qualityScore: qualityScore,
      if (dxScore != $none) #dxScore: dxScore,
      if (bestCujs != null) #bestCujs: bestCujs,
      if (worstCujs != null) #worstCujs: worstCujs,
    }),
  );
  @override
  FlutterBenchEvalItem $make(CopyWithData data) => FlutterBenchEvalItem(
    evalKey: data.get(#evalKey, or: $value.evalKey),
    agentName: data.get(#agentName, or: $value.agentName),
    modelName: data.get(#modelName, or: $value.modelName),
    modelShortName: data.get(#modelShortName, or: $value.modelShortName),
    provider: data.get(#provider, or: $value.provider),
    variant: data.get(#variant, or: $value.variant),
    nTrials: data.get(#nTrials, or: $value.nTrials),
    nErrors: data.get(#nErrors, or: $value.nErrors),
    meanReward: data.get(#meanReward, or: $value.meanReward),
    minReward: data.get(#minReward, or: $value.minReward),
    maxReward: data.get(#maxReward, or: $value.maxReward),
    medianReward: data.get(#medianReward, or: $value.medianReward),
    passAt1: data.get(#passAt1, or: $value.passAt1),
    costUsd: data.get(#costUsd, or: $value.costUsd),
    inputTokens: data.get(#inputTokens, or: $value.inputTokens),
    outputTokens: data.get(#outputTokens, or: $value.outputTokens),
    hasDartTooling: data.get(#hasDartTooling, or: $value.hasDartTooling),
    outcomeScore: data.get(#outcomeScore, or: $value.outcomeScore),
    qualityScore: data.get(#qualityScore, or: $value.qualityScore),
    dxScore: data.get(#dxScore, or: $value.dxScore),
    bestCujs: data.get(#bestCujs, or: $value.bestCujs),
    worstCujs: data.get(#worstCujs, or: $value.worstCujs),
  );

  @override
  FlutterBenchEvalItemCopyWith<$R2, FlutterBenchEvalItem, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchEvalItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlutterBenchCujSummaryMapper
    extends ClassMapperBase<FlutterBenchCujSummary> {
  FlutterBenchCujSummaryMapper._();

  static FlutterBenchCujSummaryMapper? _instance;
  static FlutterBenchCujSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlutterBenchCujSummaryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchCujSummary';

  static String _$taskSlug(FlutterBenchCujSummary v) => v.taskSlug;
  static const Field<FlutterBenchCujSummary, String> _f$taskSlug = Field(
    'taskSlug',
    _$taskSlug,
    key: r'task_slug',
  );
  static String _$taskName(FlutterBenchCujSummary v) => v.taskName;
  static const Field<FlutterBenchCujSummary, String> _f$taskName = Field(
    'taskName',
    _$taskName,
    key: r'task_name',
  );
  static double? _$reward(FlutterBenchCujSummary v) => v.reward;
  static const Field<FlutterBenchCujSummary, double> _f$reward = Field(
    'reward',
    _$reward,
    opt: true,
  );
  static String _$status(FlutterBenchCujSummary v) => v.status;
  static const Field<FlutterBenchCujSummary, String> _f$status = Field(
    'status',
    _$status,
  );

  @override
  final MappableFields<FlutterBenchCujSummary> fields = const {
    #taskSlug: _f$taskSlug,
    #taskName: _f$taskName,
    #reward: _f$reward,
    #status: _f$status,
  };

  static FlutterBenchCujSummary _instantiate(DecodingData data) {
    return FlutterBenchCujSummary(
      taskSlug: data.dec(_f$taskSlug),
      taskName: data.dec(_f$taskName),
      reward: data.dec(_f$reward),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchCujSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchCujSummary>(map);
  }

  static FlutterBenchCujSummary fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchCujSummary>(json);
  }
}

mixin FlutterBenchCujSummaryMappable {
  String toJson() {
    return FlutterBenchCujSummaryMapper.ensureInitialized()
        .encodeJson<FlutterBenchCujSummary>(this as FlutterBenchCujSummary);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchCujSummaryMapper.ensureInitialized()
        .encodeMap<FlutterBenchCujSummary>(this as FlutterBenchCujSummary);
  }

  FlutterBenchCujSummaryCopyWith<
    FlutterBenchCujSummary,
    FlutterBenchCujSummary,
    FlutterBenchCujSummary
  >
  get copyWith =>
      _FlutterBenchCujSummaryCopyWithImpl<
        FlutterBenchCujSummary,
        FlutterBenchCujSummary
      >(this as FlutterBenchCujSummary, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchCujSummaryMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchCujSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchCujSummaryMapper.ensureInitialized().equalsValue(
      this as FlutterBenchCujSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchCujSummaryMapper.ensureInitialized().hashValue(
      this as FlutterBenchCujSummary,
    );
  }
}

extension FlutterBenchCujSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchCujSummary, $Out> {
  FlutterBenchCujSummaryCopyWith<$R, FlutterBenchCujSummary, $Out>
  get $asFlutterBenchCujSummary => $base.as(
    (v, t, t2) => _FlutterBenchCujSummaryCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchCujSummaryCopyWith<
  $R,
  $In extends FlutterBenchCujSummary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? taskSlug, String? taskName, double? reward, String? status});
  FlutterBenchCujSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchCujSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchCujSummary, $Out>
    implements
        FlutterBenchCujSummaryCopyWith<$R, FlutterBenchCujSummary, $Out> {
  _FlutterBenchCujSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchCujSummary> $mapper =
      FlutterBenchCujSummaryMapper.ensureInitialized();
  @override
  $R call({
    String? taskSlug,
    String? taskName,
    Object? reward = $none,
    String? status,
  }) => $apply(
    FieldCopyWithData({
      if (taskSlug != null) #taskSlug: taskSlug,
      if (taskName != null) #taskName: taskName,
      if (reward != $none) #reward: reward,
      if (status != null) #status: status,
    }),
  );
  @override
  FlutterBenchCujSummary $make(CopyWithData data) => FlutterBenchCujSummary(
    taskSlug: data.get(#taskSlug, or: $value.taskSlug),
    taskName: data.get(#taskName, or: $value.taskName),
    reward: data.get(#reward, or: $value.reward),
    status: data.get(#status, or: $value.status),
  );

  @override
  FlutterBenchCujSummaryCopyWith<$R2, FlutterBenchCujSummary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchCujSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlutterBenchTasksDataMapper
    extends ClassMapperBase<FlutterBenchTasksData> {
  FlutterBenchTasksDataMapper._();

  static FlutterBenchTasksDataMapper? _instance;
  static FlutterBenchTasksDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlutterBenchTasksDataMapper._());
      FlutterBenchTaskItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchTasksData';

  static List<FlutterBenchTaskItem> _$tasks(FlutterBenchTasksData v) => v.tasks;
  static const Field<FlutterBenchTasksData, List<FlutterBenchTaskItem>>
  _f$tasks = Field('tasks', _$tasks);

  @override
  final MappableFields<FlutterBenchTasksData> fields = const {#tasks: _f$tasks};

  static FlutterBenchTasksData _instantiate(DecodingData data) {
    return FlutterBenchTasksData(tasks: data.dec(_f$tasks));
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchTasksData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchTasksData>(map);
  }

  static FlutterBenchTasksData fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchTasksData>(json);
  }
}

mixin FlutterBenchTasksDataMappable {
  String toJson() {
    return FlutterBenchTasksDataMapper.ensureInitialized()
        .encodeJson<FlutterBenchTasksData>(this as FlutterBenchTasksData);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchTasksDataMapper.ensureInitialized()
        .encodeMap<FlutterBenchTasksData>(this as FlutterBenchTasksData);
  }

  FlutterBenchTasksDataCopyWith<
    FlutterBenchTasksData,
    FlutterBenchTasksData,
    FlutterBenchTasksData
  >
  get copyWith =>
      _FlutterBenchTasksDataCopyWithImpl<
        FlutterBenchTasksData,
        FlutterBenchTasksData
      >(this as FlutterBenchTasksData, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchTasksDataMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchTasksData,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchTasksDataMapper.ensureInitialized().equalsValue(
      this as FlutterBenchTasksData,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchTasksDataMapper.ensureInitialized().hashValue(
      this as FlutterBenchTasksData,
    );
  }
}

extension FlutterBenchTasksDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchTasksData, $Out> {
  FlutterBenchTasksDataCopyWith<$R, FlutterBenchTasksData, $Out>
  get $asFlutterBenchTasksData => $base.as(
    (v, t, t2) => _FlutterBenchTasksDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchTasksDataCopyWith<
  $R,
  $In extends FlutterBenchTasksData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    FlutterBenchTaskItem,
    FlutterBenchTaskItemCopyWith<$R, FlutterBenchTaskItem, FlutterBenchTaskItem>
  >
  get tasks;
  $R call({List<FlutterBenchTaskItem>? tasks});
  FlutterBenchTasksDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchTasksDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchTasksData, $Out>
    implements FlutterBenchTasksDataCopyWith<$R, FlutterBenchTasksData, $Out> {
  _FlutterBenchTasksDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchTasksData> $mapper =
      FlutterBenchTasksDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    FlutterBenchTaskItem,
    FlutterBenchTaskItemCopyWith<$R, FlutterBenchTaskItem, FlutterBenchTaskItem>
  >
  get tasks => ListCopyWith(
    $value.tasks,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(tasks: v),
  );
  @override
  $R call({List<FlutterBenchTaskItem>? tasks}) =>
      $apply(FieldCopyWithData({if (tasks != null) #tasks: tasks}));
  @override
  FlutterBenchTasksData $make(CopyWithData data) =>
      FlutterBenchTasksData(tasks: data.get(#tasks, or: $value.tasks));

  @override
  FlutterBenchTasksDataCopyWith<$R2, FlutterBenchTasksData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchTasksDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlutterBenchTaskItemMapper extends ClassMapperBase<FlutterBenchTaskItem> {
  FlutterBenchTaskItemMapper._();

  static FlutterBenchTaskItemMapper? _instance;
  static FlutterBenchTaskItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlutterBenchTaskItemMapper._());
      FlutterBenchTrialSummaryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchTaskItem';

  static String _$slug(FlutterBenchTaskItem v) => v.slug;
  static const Field<FlutterBenchTaskItem, String> _f$slug = Field(
    'slug',
    _$slug,
  );
  static String _$taskName(FlutterBenchTaskItem v) => v.taskName;
  static const Field<FlutterBenchTaskItem, String> _f$taskName = Field(
    'taskName',
    _$taskName,
    key: r'task_name',
  );
  static String _$displayName(FlutterBenchTaskItem v) => v.displayName;
  static const Field<FlutterBenchTaskItem, String> _f$displayName = Field(
    'displayName',
    _$displayName,
    key: r'display_name',
  );
  static String _$category(FlutterBenchTaskItem v) => v.category;
  static const Field<FlutterBenchTaskItem, String> _f$category = Field(
    'category',
    _$category,
  );
  static String _$description(FlutterBenchTaskItem v) => v.description;
  static const Field<FlutterBenchTaskItem, String> _f$description = Field(
    'description',
    _$description,
  );
  static List<FlutterBenchTrialSummary> _$trials(FlutterBenchTaskItem v) =>
      v.trials;
  static const Field<FlutterBenchTaskItem, List<FlutterBenchTrialSummary>>
  _f$trials = Field('trials', _$trials, opt: true, def: const []);
  static Map<String, Object?> _$scoresByEval(FlutterBenchTaskItem v) =>
      v.scoresByEval;
  static const Field<FlutterBenchTaskItem, Map<String, Object?>>
  _f$scoresByEval = Field(
    'scoresByEval',
    _$scoresByEval,
    key: r'scores_by_eval',
    opt: true,
    def: const {},
  );

  @override
  final MappableFields<FlutterBenchTaskItem> fields = const {
    #slug: _f$slug,
    #taskName: _f$taskName,
    #displayName: _f$displayName,
    #category: _f$category,
    #description: _f$description,
    #trials: _f$trials,
    #scoresByEval: _f$scoresByEval,
  };

  static FlutterBenchTaskItem _instantiate(DecodingData data) {
    return FlutterBenchTaskItem(
      slug: data.dec(_f$slug),
      taskName: data.dec(_f$taskName),
      displayName: data.dec(_f$displayName),
      category: data.dec(_f$category),
      description: data.dec(_f$description),
      trials: data.dec(_f$trials),
      scoresByEval: data.dec(_f$scoresByEval),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchTaskItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchTaskItem>(map);
  }

  static FlutterBenchTaskItem fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchTaskItem>(json);
  }
}

mixin FlutterBenchTaskItemMappable {
  String toJson() {
    return FlutterBenchTaskItemMapper.ensureInitialized()
        .encodeJson<FlutterBenchTaskItem>(this as FlutterBenchTaskItem);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchTaskItemMapper.ensureInitialized()
        .encodeMap<FlutterBenchTaskItem>(this as FlutterBenchTaskItem);
  }

  FlutterBenchTaskItemCopyWith<
    FlutterBenchTaskItem,
    FlutterBenchTaskItem,
    FlutterBenchTaskItem
  >
  get copyWith =>
      _FlutterBenchTaskItemCopyWithImpl<
        FlutterBenchTaskItem,
        FlutterBenchTaskItem
      >(this as FlutterBenchTaskItem, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchTaskItemMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchTaskItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchTaskItemMapper.ensureInitialized().equalsValue(
      this as FlutterBenchTaskItem,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchTaskItemMapper.ensureInitialized().hashValue(
      this as FlutterBenchTaskItem,
    );
  }
}

extension FlutterBenchTaskItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchTaskItem, $Out> {
  FlutterBenchTaskItemCopyWith<$R, FlutterBenchTaskItem, $Out>
  get $asFlutterBenchTaskItem => $base.as(
    (v, t, t2) => _FlutterBenchTaskItemCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchTaskItemCopyWith<
  $R,
  $In extends FlutterBenchTaskItem,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    FlutterBenchTrialSummary,
    FlutterBenchTrialSummaryCopyWith<
      $R,
      FlutterBenchTrialSummary,
      FlutterBenchTrialSummary
    >
  >
  get trials;
  MapCopyWith<$R, String, Object?, ObjectCopyWith<$R, Object?, Object?>?>
  get scoresByEval;
  $R call({
    String? slug,
    String? taskName,
    String? displayName,
    String? category,
    String? description,
    List<FlutterBenchTrialSummary>? trials,
    Map<String, Object?>? scoresByEval,
  });
  FlutterBenchTaskItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchTaskItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchTaskItem, $Out>
    implements FlutterBenchTaskItemCopyWith<$R, FlutterBenchTaskItem, $Out> {
  _FlutterBenchTaskItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchTaskItem> $mapper =
      FlutterBenchTaskItemMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    FlutterBenchTrialSummary,
    FlutterBenchTrialSummaryCopyWith<
      $R,
      FlutterBenchTrialSummary,
      FlutterBenchTrialSummary
    >
  >
  get trials => ListCopyWith(
    $value.trials,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(trials: v),
  );
  @override
  MapCopyWith<$R, String, Object?, ObjectCopyWith<$R, Object?, Object?>?>
  get scoresByEval => MapCopyWith(
    $value.scoresByEval,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(scoresByEval: v),
  );
  @override
  $R call({
    String? slug,
    String? taskName,
    String? displayName,
    String? category,
    String? description,
    List<FlutterBenchTrialSummary>? trials,
    Map<String, Object?>? scoresByEval,
  }) => $apply(
    FieldCopyWithData({
      if (slug != null) #slug: slug,
      if (taskName != null) #taskName: taskName,
      if (displayName != null) #displayName: displayName,
      if (category != null) #category: category,
      if (description != null) #description: description,
      if (trials != null) #trials: trials,
      if (scoresByEval != null) #scoresByEval: scoresByEval,
    }),
  );
  @override
  FlutterBenchTaskItem $make(CopyWithData data) => FlutterBenchTaskItem(
    slug: data.get(#slug, or: $value.slug),
    taskName: data.get(#taskName, or: $value.taskName),
    displayName: data.get(#displayName, or: $value.displayName),
    category: data.get(#category, or: $value.category),
    description: data.get(#description, or: $value.description),
    trials: data.get(#trials, or: $value.trials),
    scoresByEval: data.get(#scoresByEval, or: $value.scoresByEval),
  );

  @override
  FlutterBenchTaskItemCopyWith<$R2, FlutterBenchTaskItem, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchTaskItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlutterBenchTrialSummaryMapper
    extends ClassMapperBase<FlutterBenchTrialSummary> {
  FlutterBenchTrialSummaryMapper._();

  static FlutterBenchTrialSummaryMapper? _instance;
  static FlutterBenchTrialSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = FlutterBenchTrialSummaryMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchTrialSummary';

  static String _$trialName(FlutterBenchTrialSummary v) => v.trialName;
  static const Field<FlutterBenchTrialSummary, String> _f$trialName = Field(
    'trialName',
    _$trialName,
    key: r'trial_name',
  );
  static String _$status(FlutterBenchTrialSummary v) => v.status;
  static const Field<FlutterBenchTrialSummary, String> _f$status = Field(
    'status',
    _$status,
  );
  static double? _$reward(FlutterBenchTrialSummary v) => v.reward;
  static const Field<FlutterBenchTrialSummary, double> _f$reward = Field(
    'reward',
    _$reward,
    opt: true,
  );
  static String _$modelName(FlutterBenchTrialSummary v) => v.modelName;
  static const Field<FlutterBenchTrialSummary, String> _f$modelName = Field(
    'modelName',
    _$modelName,
    key: r'model_name',
  );
  static String _$modelShortName(FlutterBenchTrialSummary v) =>
      v.modelShortName;
  static const Field<FlutterBenchTrialSummary, String> _f$modelShortName =
      Field('modelShortName', _$modelShortName, key: r'model_short_name');
  static String _$agentName(FlutterBenchTrialSummary v) => v.agentName;
  static const Field<FlutterBenchTrialSummary, String> _f$agentName = Field(
    'agentName',
    _$agentName,
    key: r'agent_name',
  );
  static bool _$hasDartTooling(FlutterBenchTrialSummary v) => v.hasDartTooling;
  static const Field<FlutterBenchTrialSummary, bool> _f$hasDartTooling = Field(
    'hasDartTooling',
    _$hasDartTooling,
    key: r'has_dart_tooling',
  );
  static String? _$exceptionType(FlutterBenchTrialSummary v) => v.exceptionType;
  static const Field<FlutterBenchTrialSummary, String> _f$exceptionType = Field(
    'exceptionType',
    _$exceptionType,
    key: r'exception_type',
    opt: true,
  );

  @override
  final MappableFields<FlutterBenchTrialSummary> fields = const {
    #trialName: _f$trialName,
    #status: _f$status,
    #reward: _f$reward,
    #modelName: _f$modelName,
    #modelShortName: _f$modelShortName,
    #agentName: _f$agentName,
    #hasDartTooling: _f$hasDartTooling,
    #exceptionType: _f$exceptionType,
  };

  static FlutterBenchTrialSummary _instantiate(DecodingData data) {
    return FlutterBenchTrialSummary(
      trialName: data.dec(_f$trialName),
      status: data.dec(_f$status),
      reward: data.dec(_f$reward),
      modelName: data.dec(_f$modelName),
      modelShortName: data.dec(_f$modelShortName),
      agentName: data.dec(_f$agentName),
      hasDartTooling: data.dec(_f$hasDartTooling),
      exceptionType: data.dec(_f$exceptionType),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchTrialSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchTrialSummary>(map);
  }

  static FlutterBenchTrialSummary fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchTrialSummary>(json);
  }
}

mixin FlutterBenchTrialSummaryMappable {
  String toJson() {
    return FlutterBenchTrialSummaryMapper.ensureInitialized()
        .encodeJson<FlutterBenchTrialSummary>(this as FlutterBenchTrialSummary);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchTrialSummaryMapper.ensureInitialized()
        .encodeMap<FlutterBenchTrialSummary>(this as FlutterBenchTrialSummary);
  }

  FlutterBenchTrialSummaryCopyWith<
    FlutterBenchTrialSummary,
    FlutterBenchTrialSummary,
    FlutterBenchTrialSummary
  >
  get copyWith =>
      _FlutterBenchTrialSummaryCopyWithImpl<
        FlutterBenchTrialSummary,
        FlutterBenchTrialSummary
      >(this as FlutterBenchTrialSummary, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchTrialSummaryMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchTrialSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchTrialSummaryMapper.ensureInitialized().equalsValue(
      this as FlutterBenchTrialSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchTrialSummaryMapper.ensureInitialized().hashValue(
      this as FlutterBenchTrialSummary,
    );
  }
}

extension FlutterBenchTrialSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchTrialSummary, $Out> {
  FlutterBenchTrialSummaryCopyWith<$R, FlutterBenchTrialSummary, $Out>
  get $asFlutterBenchTrialSummary => $base.as(
    (v, t, t2) => _FlutterBenchTrialSummaryCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchTrialSummaryCopyWith<
  $R,
  $In extends FlutterBenchTrialSummary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? trialName,
    String? status,
    double? reward,
    String? modelName,
    String? modelShortName,
    String? agentName,
    bool? hasDartTooling,
    String? exceptionType,
  });
  FlutterBenchTrialSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchTrialSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchTrialSummary, $Out>
    implements
        FlutterBenchTrialSummaryCopyWith<$R, FlutterBenchTrialSummary, $Out> {
  _FlutterBenchTrialSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchTrialSummary> $mapper =
      FlutterBenchTrialSummaryMapper.ensureInitialized();
  @override
  $R call({
    String? trialName,
    String? status,
    Object? reward = $none,
    String? modelName,
    String? modelShortName,
    String? agentName,
    bool? hasDartTooling,
    Object? exceptionType = $none,
  }) => $apply(
    FieldCopyWithData({
      if (trialName != null) #trialName: trialName,
      if (status != null) #status: status,
      if (reward != $none) #reward: reward,
      if (modelName != null) #modelName: modelName,
      if (modelShortName != null) #modelShortName: modelShortName,
      if (agentName != null) #agentName: agentName,
      if (hasDartTooling != null) #hasDartTooling: hasDartTooling,
      if (exceptionType != $none) #exceptionType: exceptionType,
    }),
  );
  @override
  FlutterBenchTrialSummary $make(CopyWithData data) => FlutterBenchTrialSummary(
    trialName: data.get(#trialName, or: $value.trialName),
    status: data.get(#status, or: $value.status),
    reward: data.get(#reward, or: $value.reward),
    modelName: data.get(#modelName, or: $value.modelName),
    modelShortName: data.get(#modelShortName, or: $value.modelShortName),
    agentName: data.get(#agentName, or: $value.agentName),
    hasDartTooling: data.get(#hasDartTooling, or: $value.hasDartTooling),
    exceptionType: data.get(#exceptionType, or: $value.exceptionType),
  );

  @override
  FlutterBenchTrialSummaryCopyWith<$R2, FlutterBenchTrialSummary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchTrialSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlutterBenchTrialsDataMapper
    extends ClassMapperBase<FlutterBenchTrialsData> {
  FlutterBenchTrialsDataMapper._();

  static FlutterBenchTrialsDataMapper? _instance;
  static FlutterBenchTrialsDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlutterBenchTrialsDataMapper._());
      FlutterBenchTrialDetailMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchTrialsData';

  static List<FlutterBenchTrialDetail> _$trials(FlutterBenchTrialsData v) =>
      v.trials;
  static const Field<FlutterBenchTrialsData, List<FlutterBenchTrialDetail>>
  _f$trials = Field('trials', _$trials);

  @override
  final MappableFields<FlutterBenchTrialsData> fields = const {
    #trials: _f$trials,
  };

  static FlutterBenchTrialsData _instantiate(DecodingData data) {
    return FlutterBenchTrialsData(trials: data.dec(_f$trials));
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchTrialsData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchTrialsData>(map);
  }

  static FlutterBenchTrialsData fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchTrialsData>(json);
  }
}

mixin FlutterBenchTrialsDataMappable {
  String toJson() {
    return FlutterBenchTrialsDataMapper.ensureInitialized()
        .encodeJson<FlutterBenchTrialsData>(this as FlutterBenchTrialsData);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchTrialsDataMapper.ensureInitialized()
        .encodeMap<FlutterBenchTrialsData>(this as FlutterBenchTrialsData);
  }

  FlutterBenchTrialsDataCopyWith<
    FlutterBenchTrialsData,
    FlutterBenchTrialsData,
    FlutterBenchTrialsData
  >
  get copyWith =>
      _FlutterBenchTrialsDataCopyWithImpl<
        FlutterBenchTrialsData,
        FlutterBenchTrialsData
      >(this as FlutterBenchTrialsData, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchTrialsDataMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchTrialsData,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchTrialsDataMapper.ensureInitialized().equalsValue(
      this as FlutterBenchTrialsData,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchTrialsDataMapper.ensureInitialized().hashValue(
      this as FlutterBenchTrialsData,
    );
  }
}

extension FlutterBenchTrialsDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchTrialsData, $Out> {
  FlutterBenchTrialsDataCopyWith<$R, FlutterBenchTrialsData, $Out>
  get $asFlutterBenchTrialsData => $base.as(
    (v, t, t2) => _FlutterBenchTrialsDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchTrialsDataCopyWith<
  $R,
  $In extends FlutterBenchTrialsData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    FlutterBenchTrialDetail,
    FlutterBenchTrialDetailCopyWith<
      $R,
      FlutterBenchTrialDetail,
      FlutterBenchTrialDetail
    >
  >
  get trials;
  $R call({List<FlutterBenchTrialDetail>? trials});
  FlutterBenchTrialsDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchTrialsDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchTrialsData, $Out>
    implements
        FlutterBenchTrialsDataCopyWith<$R, FlutterBenchTrialsData, $Out> {
  _FlutterBenchTrialsDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchTrialsData> $mapper =
      FlutterBenchTrialsDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    FlutterBenchTrialDetail,
    FlutterBenchTrialDetailCopyWith<
      $R,
      FlutterBenchTrialDetail,
      FlutterBenchTrialDetail
    >
  >
  get trials => ListCopyWith(
    $value.trials,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(trials: v),
  );
  @override
  $R call({List<FlutterBenchTrialDetail>? trials}) =>
      $apply(FieldCopyWithData({if (trials != null) #trials: trials}));
  @override
  FlutterBenchTrialsData $make(CopyWithData data) =>
      FlutterBenchTrialsData(trials: data.get(#trials, or: $value.trials));

  @override
  FlutterBenchTrialsDataCopyWith<$R2, FlutterBenchTrialsData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchTrialsDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlutterBenchTrialDetailMapper
    extends ClassMapperBase<FlutterBenchTrialDetail> {
  FlutterBenchTrialDetailMapper._();

  static FlutterBenchTrialDetailMapper? _instance;
  static FlutterBenchTrialDetailMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = FlutterBenchTrialDetailMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'FlutterBenchTrialDetail';

  static String _$trialName(FlutterBenchTrialDetail v) => v.trialName;
  static const Field<FlutterBenchTrialDetail, String> _f$trialName = Field(
    'trialName',
    _$trialName,
    key: r'trial_name',
  );
  static String _$taskName(FlutterBenchTrialDetail v) => v.taskName;
  static const Field<FlutterBenchTrialDetail, String> _f$taskName = Field(
    'taskName',
    _$taskName,
    key: r'task_name',
  );
  static String _$taskSlug(FlutterBenchTrialDetail v) => v.taskSlug;
  static const Field<FlutterBenchTrialDetail, String> _f$taskSlug = Field(
    'taskSlug',
    _$taskSlug,
    key: r'task_slug',
  );
  static String _$agentName(FlutterBenchTrialDetail v) => v.agentName;
  static const Field<FlutterBenchTrialDetail, String> _f$agentName = Field(
    'agentName',
    _$agentName,
    key: r'agent_name',
  );
  static String _$modelName(FlutterBenchTrialDetail v) => v.modelName;
  static const Field<FlutterBenchTrialDetail, String> _f$modelName = Field(
    'modelName',
    _$modelName,
    key: r'model_name',
  );
  static String _$modelShortName(FlutterBenchTrialDetail v) => v.modelShortName;
  static const Field<FlutterBenchTrialDetail, String> _f$modelShortName = Field(
    'modelShortName',
    _$modelShortName,
    key: r'model_short_name',
  );
  static String _$provider(FlutterBenchTrialDetail v) => v.provider;
  static const Field<FlutterBenchTrialDetail, String> _f$provider = Field(
    'provider',
    _$provider,
  );
  static List<String> _$skills(FlutterBenchTrialDetail v) => v.skills;
  static const Field<FlutterBenchTrialDetail, List<String>> _f$skills = Field(
    'skills',
    _$skills,
    opt: true,
    def: const [],
  );
  static List<String> _$mcpServers(FlutterBenchTrialDetail v) => v.mcpServers;
  static const Field<FlutterBenchTrialDetail, List<String>> _f$mcpServers =
      Field(
        'mcpServers',
        _$mcpServers,
        key: r'mcp_servers',
        opt: true,
        def: const [],
      );
  static bool _$hasDartTooling(FlutterBenchTrialDetail v) => v.hasDartTooling;
  static const Field<FlutterBenchTrialDetail, bool> _f$hasDartTooling = Field(
    'hasDartTooling',
    _$hasDartTooling,
    key: r'has_dart_tooling',
  );
  static String _$status(FlutterBenchTrialDetail v) => v.status;
  static const Field<FlutterBenchTrialDetail, String> _f$status = Field(
    'status',
    _$status,
  );
  static double? _$reward(FlutterBenchTrialDetail v) => v.reward;
  static const Field<FlutterBenchTrialDetail, double> _f$reward = Field(
    'reward',
    _$reward,
    opt: true,
  );
  static String? _$exceptionType(FlutterBenchTrialDetail v) => v.exceptionType;
  static const Field<FlutterBenchTrialDetail, String> _f$exceptionType = Field(
    'exceptionType',
    _$exceptionType,
    key: r'exception_type',
    opt: true,
  );
  static String? _$exceptionMessage(FlutterBenchTrialDetail v) =>
      v.exceptionMessage;
  static const Field<FlutterBenchTrialDetail, String> _f$exceptionMessage =
      Field(
        'exceptionMessage',
        _$exceptionMessage,
        key: r'exception_message',
        opt: true,
      );
  static String? _$exceptionTraceback(FlutterBenchTrialDetail v) =>
      v.exceptionTraceback;
  static const Field<FlutterBenchTrialDetail, String> _f$exceptionTraceback =
      Field(
        'exceptionTraceback',
        _$exceptionTraceback,
        key: r'exception_traceback',
        opt: true,
      );
  static Map<String, double> _$durations(FlutterBenchTrialDetail v) =>
      v.durations;
  static const Field<FlutterBenchTrialDetail, Map<String, double>>
  _f$durations = Field('durations', _$durations, opt: true, def: const {});
  static int _$inputTokens(FlutterBenchTrialDetail v) => v.inputTokens;
  static const Field<FlutterBenchTrialDetail, int> _f$inputTokens = Field(
    'inputTokens',
    _$inputTokens,
    key: r'input_tokens',
  );
  static int _$cacheTokens(FlutterBenchTrialDetail v) => v.cacheTokens;
  static const Field<FlutterBenchTrialDetail, int> _f$cacheTokens = Field(
    'cacheTokens',
    _$cacheTokens,
    key: r'cache_tokens',
  );
  static int _$outputTokens(FlutterBenchTrialDetail v) => v.outputTokens;
  static const Field<FlutterBenchTrialDetail, int> _f$outputTokens = Field(
    'outputTokens',
    _$outputTokens,
    key: r'output_tokens',
  );
  static double _$costUsd(FlutterBenchTrialDetail v) => v.costUsd;
  static const Field<FlutterBenchTrialDetail, double> _f$costUsd = Field(
    'costUsd',
    _$costUsd,
    key: r'cost_usd',
  );
  static Map<String, Object?>? _$rewardTree(FlutterBenchTrialDetail v) =>
      v.rewardTree;
  static const Field<FlutterBenchTrialDetail, Map<String, Object?>>
  _f$rewardTree = Field(
    'rewardTree',
    _$rewardTree,
    key: r'reward_tree',
    opt: true,
  );
  static Map<String, Object?> _$diagnosticTree(FlutterBenchTrialDetail v) =>
      v.diagnosticTree;
  static const Field<FlutterBenchTrialDetail, Map<String, Object?>>
  _f$diagnosticTree = Field(
    'diagnosticTree',
    _$diagnosticTree,
    key: r'diagnostic_tree',
    opt: true,
    def: const {},
  );
  static List<Map<String, Object?>>? _$trajectory(FlutterBenchTrialDetail v) =>
      v.trajectory;
  static const Field<FlutterBenchTrialDetail, List<Map<String, Object?>>>
  _f$trajectory = Field('trajectory', _$trajectory, opt: true);
  static List<Map<String, Object?>> _$artifacts(FlutterBenchTrialDetail v) =>
      v.artifacts;
  static const Field<FlutterBenchTrialDetail, List<Map<String, Object?>>>
  _f$artifacts = Field('artifacts', _$artifacts, opt: true, def: const []);
  static String? _$testStdout(FlutterBenchTrialDetail v) => v.testStdout;
  static const Field<FlutterBenchTrialDetail, String> _f$testStdout = Field(
    'testStdout',
    _$testStdout,
    key: r'test_stdout',
    opt: true,
  );
  static String? _$exceptionLog(FlutterBenchTrialDetail v) => v.exceptionLog;
  static const Field<FlutterBenchTrialDetail, String> _f$exceptionLog = Field(
    'exceptionLog',
    _$exceptionLog,
    key: r'exception_log',
    opt: true,
  );

  @override
  final MappableFields<FlutterBenchTrialDetail> fields = const {
    #trialName: _f$trialName,
    #taskName: _f$taskName,
    #taskSlug: _f$taskSlug,
    #agentName: _f$agentName,
    #modelName: _f$modelName,
    #modelShortName: _f$modelShortName,
    #provider: _f$provider,
    #skills: _f$skills,
    #mcpServers: _f$mcpServers,
    #hasDartTooling: _f$hasDartTooling,
    #status: _f$status,
    #reward: _f$reward,
    #exceptionType: _f$exceptionType,
    #exceptionMessage: _f$exceptionMessage,
    #exceptionTraceback: _f$exceptionTraceback,
    #durations: _f$durations,
    #inputTokens: _f$inputTokens,
    #cacheTokens: _f$cacheTokens,
    #outputTokens: _f$outputTokens,
    #costUsd: _f$costUsd,
    #rewardTree: _f$rewardTree,
    #diagnosticTree: _f$diagnosticTree,
    #trajectory: _f$trajectory,
    #artifacts: _f$artifacts,
    #testStdout: _f$testStdout,
    #exceptionLog: _f$exceptionLog,
  };

  static FlutterBenchTrialDetail _instantiate(DecodingData data) {
    return FlutterBenchTrialDetail(
      trialName: data.dec(_f$trialName),
      taskName: data.dec(_f$taskName),
      taskSlug: data.dec(_f$taskSlug),
      agentName: data.dec(_f$agentName),
      modelName: data.dec(_f$modelName),
      modelShortName: data.dec(_f$modelShortName),
      provider: data.dec(_f$provider),
      skills: data.dec(_f$skills),
      mcpServers: data.dec(_f$mcpServers),
      hasDartTooling: data.dec(_f$hasDartTooling),
      status: data.dec(_f$status),
      reward: data.dec(_f$reward),
      exceptionType: data.dec(_f$exceptionType),
      exceptionMessage: data.dec(_f$exceptionMessage),
      exceptionTraceback: data.dec(_f$exceptionTraceback),
      durations: data.dec(_f$durations),
      inputTokens: data.dec(_f$inputTokens),
      cacheTokens: data.dec(_f$cacheTokens),
      outputTokens: data.dec(_f$outputTokens),
      costUsd: data.dec(_f$costUsd),
      rewardTree: data.dec(_f$rewardTree),
      diagnosticTree: data.dec(_f$diagnosticTree),
      trajectory: data.dec(_f$trajectory),
      artifacts: data.dec(_f$artifacts),
      testStdout: data.dec(_f$testStdout),
      exceptionLog: data.dec(_f$exceptionLog),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FlutterBenchTrialDetail fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlutterBenchTrialDetail>(map);
  }

  static FlutterBenchTrialDetail fromJson(String json) {
    return ensureInitialized().decodeJson<FlutterBenchTrialDetail>(json);
  }
}

mixin FlutterBenchTrialDetailMappable {
  String toJson() {
    return FlutterBenchTrialDetailMapper.ensureInitialized()
        .encodeJson<FlutterBenchTrialDetail>(this as FlutterBenchTrialDetail);
  }

  Map<String, dynamic> toMap() {
    return FlutterBenchTrialDetailMapper.ensureInitialized()
        .encodeMap<FlutterBenchTrialDetail>(this as FlutterBenchTrialDetail);
  }

  FlutterBenchTrialDetailCopyWith<
    FlutterBenchTrialDetail,
    FlutterBenchTrialDetail,
    FlutterBenchTrialDetail
  >
  get copyWith =>
      _FlutterBenchTrialDetailCopyWithImpl<
        FlutterBenchTrialDetail,
        FlutterBenchTrialDetail
      >(this as FlutterBenchTrialDetail, $identity, $identity);
  @override
  String toString() {
    return FlutterBenchTrialDetailMapper.ensureInitialized().stringifyValue(
      this as FlutterBenchTrialDetail,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlutterBenchTrialDetailMapper.ensureInitialized().equalsValue(
      this as FlutterBenchTrialDetail,
      other,
    );
  }

  @override
  int get hashCode {
    return FlutterBenchTrialDetailMapper.ensureInitialized().hashValue(
      this as FlutterBenchTrialDetail,
    );
  }
}

extension FlutterBenchTrialDetailValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlutterBenchTrialDetail, $Out> {
  FlutterBenchTrialDetailCopyWith<$R, FlutterBenchTrialDetail, $Out>
  get $asFlutterBenchTrialDetail => $base.as(
    (v, t, t2) => _FlutterBenchTrialDetailCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class FlutterBenchTrialDetailCopyWith<
  $R,
  $In extends FlutterBenchTrialDetail,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get skills;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get mcpServers;
  MapCopyWith<$R, String, double, ObjectCopyWith<$R, double, double>>
  get durations;
  MapCopyWith<$R, String, Object?, ObjectCopyWith<$R, Object?, Object?>?>?
  get rewardTree;
  MapCopyWith<$R, String, Object?, ObjectCopyWith<$R, Object?, Object?>?>
  get diagnosticTree;
  ListCopyWith<
    $R,
    Map<String, Object?>,
    ObjectCopyWith<$R, Map<String, Object?>, Map<String, Object?>>
  >?
  get trajectory;
  ListCopyWith<
    $R,
    Map<String, Object?>,
    ObjectCopyWith<$R, Map<String, Object?>, Map<String, Object?>>
  >
  get artifacts;
  $R call({
    String? trialName,
    String? taskName,
    String? taskSlug,
    String? agentName,
    String? modelName,
    String? modelShortName,
    String? provider,
    List<String>? skills,
    List<String>? mcpServers,
    bool? hasDartTooling,
    String? status,
    double? reward,
    String? exceptionType,
    String? exceptionMessage,
    String? exceptionTraceback,
    Map<String, double>? durations,
    int? inputTokens,
    int? cacheTokens,
    int? outputTokens,
    double? costUsd,
    Map<String, Object?>? rewardTree,
    Map<String, Object?>? diagnosticTree,
    List<Map<String, Object?>>? trajectory,
    List<Map<String, Object?>>? artifacts,
    String? testStdout,
    String? exceptionLog,
  });
  FlutterBenchTrialDetailCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _FlutterBenchTrialDetailCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlutterBenchTrialDetail, $Out>
    implements
        FlutterBenchTrialDetailCopyWith<$R, FlutterBenchTrialDetail, $Out> {
  _FlutterBenchTrialDetailCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlutterBenchTrialDetail> $mapper =
      FlutterBenchTrialDetailMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get skills =>
      ListCopyWith(
        $value.skills,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(skills: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get mcpServers =>
      ListCopyWith(
        $value.mcpServers,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(mcpServers: v),
      );
  @override
  MapCopyWith<$R, String, double, ObjectCopyWith<$R, double, double>>
  get durations => MapCopyWith(
    $value.durations,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(durations: v),
  );
  @override
  MapCopyWith<$R, String, Object?, ObjectCopyWith<$R, Object?, Object?>?>?
  get rewardTree => $value.rewardTree != null
      ? MapCopyWith(
          $value.rewardTree!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(rewardTree: v),
        )
      : null;
  @override
  MapCopyWith<$R, String, Object?, ObjectCopyWith<$R, Object?, Object?>?>
  get diagnosticTree => MapCopyWith(
    $value.diagnosticTree,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(diagnosticTree: v),
  );
  @override
  ListCopyWith<
    $R,
    Map<String, Object?>,
    ObjectCopyWith<$R, Map<String, Object?>, Map<String, Object?>>
  >?
  get trajectory => $value.trajectory != null
      ? ListCopyWith(
          $value.trajectory!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(trajectory: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    Map<String, Object?>,
    ObjectCopyWith<$R, Map<String, Object?>, Map<String, Object?>>
  >
  get artifacts => ListCopyWith(
    $value.artifacts,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(artifacts: v),
  );
  @override
  $R call({
    String? trialName,
    String? taskName,
    String? taskSlug,
    String? agentName,
    String? modelName,
    String? modelShortName,
    String? provider,
    List<String>? skills,
    List<String>? mcpServers,
    bool? hasDartTooling,
    String? status,
    Object? reward = $none,
    Object? exceptionType = $none,
    Object? exceptionMessage = $none,
    Object? exceptionTraceback = $none,
    Map<String, double>? durations,
    int? inputTokens,
    int? cacheTokens,
    int? outputTokens,
    double? costUsd,
    Object? rewardTree = $none,
    Map<String, Object?>? diagnosticTree,
    Object? trajectory = $none,
    List<Map<String, Object?>>? artifacts,
    Object? testStdout = $none,
    Object? exceptionLog = $none,
  }) => $apply(
    FieldCopyWithData({
      if (trialName != null) #trialName: trialName,
      if (taskName != null) #taskName: taskName,
      if (taskSlug != null) #taskSlug: taskSlug,
      if (agentName != null) #agentName: agentName,
      if (modelName != null) #modelName: modelName,
      if (modelShortName != null) #modelShortName: modelShortName,
      if (provider != null) #provider: provider,
      if (skills != null) #skills: skills,
      if (mcpServers != null) #mcpServers: mcpServers,
      if (hasDartTooling != null) #hasDartTooling: hasDartTooling,
      if (status != null) #status: status,
      if (reward != $none) #reward: reward,
      if (exceptionType != $none) #exceptionType: exceptionType,
      if (exceptionMessage != $none) #exceptionMessage: exceptionMessage,
      if (exceptionTraceback != $none) #exceptionTraceback: exceptionTraceback,
      if (durations != null) #durations: durations,
      if (inputTokens != null) #inputTokens: inputTokens,
      if (cacheTokens != null) #cacheTokens: cacheTokens,
      if (outputTokens != null) #outputTokens: outputTokens,
      if (costUsd != null) #costUsd: costUsd,
      if (rewardTree != $none) #rewardTree: rewardTree,
      if (diagnosticTree != null) #diagnosticTree: diagnosticTree,
      if (trajectory != $none) #trajectory: trajectory,
      if (artifacts != null) #artifacts: artifacts,
      if (testStdout != $none) #testStdout: testStdout,
      if (exceptionLog != $none) #exceptionLog: exceptionLog,
    }),
  );
  @override
  FlutterBenchTrialDetail $make(CopyWithData data) => FlutterBenchTrialDetail(
    trialName: data.get(#trialName, or: $value.trialName),
    taskName: data.get(#taskName, or: $value.taskName),
    taskSlug: data.get(#taskSlug, or: $value.taskSlug),
    agentName: data.get(#agentName, or: $value.agentName),
    modelName: data.get(#modelName, or: $value.modelName),
    modelShortName: data.get(#modelShortName, or: $value.modelShortName),
    provider: data.get(#provider, or: $value.provider),
    skills: data.get(#skills, or: $value.skills),
    mcpServers: data.get(#mcpServers, or: $value.mcpServers),
    hasDartTooling: data.get(#hasDartTooling, or: $value.hasDartTooling),
    status: data.get(#status, or: $value.status),
    reward: data.get(#reward, or: $value.reward),
    exceptionType: data.get(#exceptionType, or: $value.exceptionType),
    exceptionMessage: data.get(#exceptionMessage, or: $value.exceptionMessage),
    exceptionTraceback: data.get(
      #exceptionTraceback,
      or: $value.exceptionTraceback,
    ),
    durations: data.get(#durations, or: $value.durations),
    inputTokens: data.get(#inputTokens, or: $value.inputTokens),
    cacheTokens: data.get(#cacheTokens, or: $value.cacheTokens),
    outputTokens: data.get(#outputTokens, or: $value.outputTokens),
    costUsd: data.get(#costUsd, or: $value.costUsd),
    rewardTree: data.get(#rewardTree, or: $value.rewardTree),
    diagnosticTree: data.get(#diagnosticTree, or: $value.diagnosticTree),
    trajectory: data.get(#trajectory, or: $value.trajectory),
    artifacts: data.get(#artifacts, or: $value.artifacts),
    testStdout: data.get(#testStdout, or: $value.testStdout),
    exceptionLog: data.get(#exceptionLog, or: $value.exceptionLog),
  );

  @override
  FlutterBenchTrialDetailCopyWith<$R2, FlutterBenchTrialDetail, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FlutterBenchTrialDetailCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

