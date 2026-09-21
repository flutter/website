// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'src/commands/analyze_dart.dart';
import 'src/commands/build.dart';
import 'src/commands/check_all.dart';
import 'src/commands/check_link_references.dart';
import 'src/commands/check_links.dart';
import 'src/commands/clean.dart';
import 'src/commands/deploy.dart';
import 'src/commands/format_dart.dart';
import 'src/commands/generate_release_notes.dart';
import 'src/commands/refresh_excerpts.dart';
import 'src/commands/serve.dart';
import 'src/commands/stage_preview.dart';
import 'src/commands/test_dart.dart';
import 'src/commands/verify_firebase_json.dart';
import 'src/sites.dart';

/// The root command runner of the Flutter website tooling.
///
/// To learn about the command, its supported options, and its subcommands,
/// run `dart run dash_site --help`.
final class DashSiteCommandRunner extends CommandRunner<int> {
  DashSiteCommandRunner()
    : super(
        'dart run dash_site',
        'Infrastructure tooling for the Flutter websites.',
      ) {
    argParser.addOption(
      siteOptionName,
      defaultsTo: Site.docs.name,
      valueHelp: Site.values.map((site) => site.name).join('|'),
      help: 'The site to operate on.',
    );

    addCommand(AnalyzeDartCommand());
    addCommand(BuildSiteCommand());
    addCommand(CheckAllCommand());
    addCommand(CheckLinksCommand());
    addCommand(CheckLinkReferencesCommand());
    addCommand(CleanSiteCommand());
    addCommand(DeployCommand());
    addCommand(FormatDartCommand());
    addCommand(GenerateReleaseNotesCommand());
    addCommand(RefreshExcerptsCommand());
    addCommand(ServeSiteCommand());
    addCommand(StagePreviewCommand());
    addCommand(TestDartCommand());
    addCommand(VerifyFirebaseJsonCommand());
  }

  @override
  ArgResults parse(Iterable<String> args) {
    final results = super.parse(args);
    final siteName = results.option(siteOptionName);

    if (siteName == 'blog') {
      usageException(
        'The Flutter blog is part of the www site. '
        'Use --site=www instead of --site=blog.',
      );
    }

    if (!Site.values.any((site) => site.name == siteName)) {
      usageException(
        'Invalid option value "$siteName" for "--$siteOptionName". '
        'Valid options: ${Site.values.map((site) => site.name).join(', ')}.',
      );
    }

    return results;
  }
}
