// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Visual regression diffing engine and interactive review tooling.
library;

export 'src/differ/batch_differ.dart';
export 'src/differ/pixel_differ.dart';
export 'src/models/diff_entry.dart';
export 'src/models/diff_manifest.dart';
export 'src/models/diff_route.dart';
export 'src/models/header_metadata.dart';
export 'src/models/route_tree_node.dart';
export 'src/runner/content_hasher.dart';
export 'src/runner/font_cache.dart';
export 'src/runner/git_worktree.dart';
export 'src/runner/header_extractor.dart';
export 'src/runner/route_discovery.dart';
export 'src/runner/snapshot_runner.dart';
export 'src/runner/snapshot_server.dart';
export 'src/runner/snapshot_viewport.dart';
export 'src/server/visual_diff_server.dart';
