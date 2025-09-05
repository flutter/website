// Copyright 2024 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';

import 'src/commands/analyze_dart.dart';
import 'src/commands/build.dart';
import 'src/commands/check_all.dart';
import 'src/commands/check_link_references.dart';
import 'src/commands/check_links.dart';
import 'src/commands/clean.dart';
import 'src/commands/format_dart.dart';
import 'src/commands/refresh_excerpts.dart';
import 'src/commands/serve.dart';
import 'src/commands/test_dart.dart';
import 'src/commands/verify_firebase_json.dart';

/// The root command runner of the `flutter_site` command.
/// To learn about it and its subcommands,
/// run `dart run flutter_site --help`.
final class FlutterSiteCommandRunner extends CommandRunner<int> {
  FlutterSiteCommandRunner()
    : super(
        'flutter_site',
        'Infrastructure tooling for the Flutter documentation website.',
      ) {
    addCommand(AnalyzeDartCommand());
    addCommand(BuildSiteCommand());
    addCommand(CheckAllCommand());
    addCommand(CheckLinksCommand());
    addCommand(CheckLinkReferencesCommand());
    addCommand(CleanSiteCommand());
    addCommand(FormatDartCommand());
    addCommand(RefreshExcerptsCommand());
    addCommand(ServeSiteCommand());
    addCommand(TestDartCommand());
    addCommand(VerifyFirebaseJsonCommand());
  }
}
