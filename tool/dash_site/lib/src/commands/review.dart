// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import '../review_server.dart';
import '../sites.dart';
import '../utils.dart';

/// CLI command for inspecting, exporting, resolving, and clearing local visual
/// review comments stored in `.dash_review/`.
final class ReviewCommand extends Command<int> {
  final String? _repoRootOverride;
  final StringSink _out;
  final StringSink _err;

  ReviewCommand({String? repoRoot, StringSink? out, StringSink? err})
    : _repoRootOverride = repoRoot,
      _out = out ?? stdout,
      _err = err ?? stderr {
    argParser.addOption(
      siteOptionName,
      allowed: [for (final site in Site.values) site.name],
      valueHelp: Site.values.map((site) => site.name).join('|'),
      help: 'Optional site filter (defaults to all sites in the workspace).',
    );

    addSubcommand(_ReviewListSubcommand(this));
    addSubcommand(_ReviewPromptSubcommand(this));
    addSubcommand(_ReviewResolveSubcommand(this));
    addSubcommand(_ReviewClearSubcommand(this));
  }

  @override
  String get name => 'review';

  @override
  String get description =>
      'Manage local visual review comments synced to .dash_review/.';

  ReviewStore get _store => ReviewStore(_repoRootOverride ?? repositoryRoot);

  String? _resolveOptionalSiteFilter(ArgResults? subcommandArgs) {
    if (subcommandArgs != null &&
        subcommandArgs.options.contains(siteOptionName) &&
        subcommandArgs.wasParsed(siteOptionName)) {
      return subcommandArgs.option(siteOptionName);
    }
    if (argResults != null && argResults!.wasParsed(siteOptionName)) {
      return argResults!.option(siteOptionName);
    }
    if (globalResults != null && globalResults!.wasParsed(siteOptionName)) {
      return globalResults!.option(siteOptionName);
    }
    return null;
  }
}

void _addSubcommandSiteOption(ArgParser parser) {
  parser.addOption(
    siteOptionName,
    allowed: [for (final site in Site.values) site.name],
    valueHelp: Site.values.map((site) => site.name).join('|'),
    help: 'Optional site filter (docs or www).',
  );
}

final class _ReviewListSubcommand extends Command<int> {
  static const String _statusOption = 'status';
  static const String _jsonFlag = 'json';

  final ReviewCommand _parent;

  _ReviewListSubcommand(this._parent) {
    _addSubcommandSiteOption(argParser);
    argParser
      ..addOption(
        _statusOption,
        allowed: const ['open', 'resolved', 'all'],
        defaultsTo: 'all',
        help: 'Filter comments by status.',
      )
      ..addFlag(
        _jsonFlag,
        defaultsTo: false,
        negatable: false,
        help: 'Print comments as JSON.',
      );
  }

  @override
  String get name => 'list';

  @override
  String get description => 'List local visual review comments.';

  @override
  Future<int> run() async {
    final args = argResults!;
    final statusFilter = args.option(_statusOption) ?? 'all';
    final outputJson = args.flag(_jsonFlag);
    final siteFilter = _parent._resolveOptionalSiteFilter(args);

    final allComments = _parent._store.loadComments();
    final siteScoped = [
      for (final item in allComments)
        if (siteFilter == null || item.site == siteFilter) item,
    ];
    final filtered = [
      for (final item in siteScoped)
        if (statusFilter == 'all' || item.status == statusFilter) item,
    ];
    final counts = computeCommentCounts(siteScoped);

    if (outputJson) {
      final payload = {
        'ok': true,
        'comments': [for (final item in filtered) item.toJson()],
        'counts': counts,
        'feedbackFile': reviewFeedbackRelativePath,
      };
      _parent._out.writeln(const JsonEncoder.withIndent('  ').convert(payload));
      return 0;
    }

    _parent._out.writeln(
      'Review comments '
      '(open: ${counts['open']}, resolved: ${counts['resolved']}, '
      'total: ${counts['total']})',
    );

    if (filtered.isEmpty) {
      _parent._out.writeln('No matching review comments.');
      return 0;
    }

    for (final item in filtered) {
      final statusBadge = item.status == 'resolved' ? 'RESOLVED' : 'OPEN';
      final summary = item.comment.replaceAll(RegExp(r'\s+'), ' ').trim();
      _parent._out.writeln(
        '[$statusBadge] ${item.id}  ${item.locationLabel}  '
        '(${item.site} ${item.pageUrl})',
      );
      if (item.selectedText.trim().isNotEmpty) {
        final quote = item.selectedText.replaceAll(RegExp(r'\s+'), ' ').trim();
        _parent._out.writeln('  Quote: "$quote"');
      }
      _parent._out.writeln('  Note: $summary');
    }

    return 0;
  }
}

final class _ReviewPromptSubcommand extends Command<int> {
  final ReviewCommand _parent;

  _ReviewPromptSubcommand(this._parent) {
    _addSubcommandSiteOption(argParser);
  }

  @override
  String get name => 'prompt';

  @override
  String get description =>
      'Print a structured coding-agent prompt for open review comments.';

  @override
  Future<int> run() async {
    final siteFilter = _parent._resolveOptionalSiteFilter(argResults);
    final comments = _parent._store.loadComments();
    final prompt = _parent._store.renderAgentPrompt(
      comments,
      siteFilter: siteFilter,
    );
    _parent._out.write(prompt);
    return 0;
  }
}

final class _ReviewResolveSubcommand extends Command<int> {
  static const String _allFlag = 'all';

  final ReviewCommand _parent;

  _ReviewResolveSubcommand(this._parent) {
    _addSubcommandSiteOption(argParser);
    argParser.addFlag(
      _allFlag,
      defaultsTo: false,
      negatable: false,
      help: 'Mark all open comments as resolved.',
    );
  }

  @override
  String get name => 'resolve';

  @override
  String get description =>
      'Mark a comment <id> (or --all) resolved and sync .dash_review/feedback.md.';

  @override
  String get invocation => '${runner!.executableName} review resolve [<id>...]';

  @override
  Future<int> run() async {
    final args = argResults!;
    final resolveAll = args.flag(_allFlag);
    final targetIds = [
      for (final restArg in args.rest)
        if (restArg.trim().isNotEmpty) restArg.trim(),
    ];

    if (!resolveAll && targetIds.isEmpty) {
      usageException('Specify at least one comment <id> or pass --all.');
    }

    final siteFilter = _parent._resolveOptionalSiteFilter(args);
    final store = _parent._store;
    final comments = store.loadComments();
    final now = DateTime.now().toUtc();
    final nowIso = now.toIso8601String();

    if (resolveAll) {
      var updatedCount = 0;
      for (var i = 0; i < comments.length; i++) {
        final item = comments[i];
        if (siteFilter != null && item.site != siteFilter) continue;
        if (item.status != 'resolved') {
          comments[i] = item.copyWith(status: 'resolved', updatedAt: nowIso);
          updatedCount++;
        }
      }
      store.saveComments(comments, now: now);
      final counts = computeCommentCounts(comments);
      _parent._out.writeln(
        'Resolved $updatedCount comment${updatedCount == 1 ? '' : 's'}. '
        'Remaining open: ${counts['open']}.',
      );
      return 0;
    }

    final missingIds = <String>[];
    var resolvedCount = 0;
    for (final targetId in targetIds) {
      final idx = comments.indexWhere((item) => item.id == targetId);
      if (idx < 0) {
        missingIds.add(targetId);
        continue;
      }
      if (comments[idx].status != 'resolved') {
        comments[idx] = comments[idx].copyWith(
          status: 'resolved',
          updatedAt: nowIso,
        );
      }
      resolvedCount++;
    }

    if (missingIds.isNotEmpty) {
      _parent._err.writeln(
        'Error: Comment ID not found: ${missingIds.join(', ')}.',
      );
      if (resolvedCount == 0) {
        return 1;
      }
    }

    store.saveComments(comments, now: now);
    final counts = computeCommentCounts(comments);
    _parent._out.writeln(
      'Resolved $resolvedCount comment${resolvedCount == 1 ? '' : 's'}. '
      'Remaining open: ${counts['open']}.',
    );
    return missingIds.isEmpty ? 0 : 1;
  }
}

final class _ReviewClearSubcommand extends Command<int> {
  static const String _resolvedFlag = 'resolved';
  static const String _allFlag = 'all';

  final ReviewCommand _parent;

  _ReviewClearSubcommand(this._parent) {
    _addSubcommandSiteOption(argParser);
    argParser
      ..addFlag(
        _resolvedFlag,
        defaultsTo: true,
        negatable: false,
        help: 'Remove resolved comments (default).',
      )
      ..addFlag(
        _allFlag,
        defaultsTo: false,
        negatable: false,
        help: 'Remove all comments (both open and resolved).',
      );
  }

  @override
  String get name => 'clear';

  @override
  String get description =>
      'Remove resolved review comments (or --all) from .dash_review/.';

  @override
  Future<int> run() async {
    final args = argResults!;
    final clearAll = args.flag(_allFlag);
    final siteFilter = _parent._resolveOptionalSiteFilter(args);

    final store = _parent._store;
    final comments = store.loadComments();
    final beforeCount = comments.length;

    comments.removeWhere((item) {
      if (siteFilter != null && item.site != siteFilter) return false;
      if (clearAll) return true;
      return item.status == 'resolved';
    });

    final removedCount = beforeCount - comments.length;
    store.saveComments(comments);
    final counts = computeCommentCounts(comments);
    _parent._out.writeln(
      'Cleared $removedCount comment${removedCount == 1 ? '' : 's'}. '
      'Remaining open: ${counts['open']}, resolved: ${counts['resolved']}.',
    );
    return 0;
  }
}
