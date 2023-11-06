// Copyright 2023 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:args/command_runner.dart';

import 'src/commands/analyze_dart.dart';
import 'src/commands/check_all.dart';
import 'src/commands/check_link_references.dart';
import 'src/commands/check_links.dart';
import 'src/commands/format_dart.dart';
import 'src/commands/refresh_excerpts.dart';
import 'src/commands/test_dart.dart';
import 'src/commands/verify_firebase_json.dart';

final class FlutterSiteCommandRunner extends CommandRunner<int> {
  FlutterSiteCommandRunner()
      : super(
          'flutter_site',
          'Infrastructure tooling for the Flutter documentation website.',
        ) {
    addCommand(CheckLinksCommand());
    addCommand(CheckLinkReferencesCommand());
    addCommand(VerifyFirebaseJsonCommand());
    addCommand(RefreshExcerptsCommand());
    addCommand(FormatDartCommand());
    addCommand(AnalyzeDartCommand());
    addCommand(TestDartCommand());
    addCommand(CheckAllCommand());
  }
}
