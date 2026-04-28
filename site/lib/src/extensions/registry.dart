// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';
import 'package:site_shared/extensions/attribute_processor.dart';
import 'package:site_shared/extensions/code_block_processor.dart';
import 'package:site_shared/extensions/header_extractor.dart';
import 'package:site_shared/extensions/header_processor.dart';
import 'package:site_shared/extensions/table_processor.dart';

import 'glossary_link_processor.dart';
import 'tutorial_navigation.dart';
import 'tutorial_structure_processor.dart';

/// A list of all node-processing, page extensions to applied to
/// content loaded with Jaspr Content.
const List<PageExtension> allNodeProcessingExtensions = [
  AttributeProcessor(),
  HeaderExtractorExtension(),
  HeaderWrapperExtension(),
  TableWrapperExtension(),
  CodeBlockProcessor(defaultTitle: 'Runnable Flutter example'),
  GlossaryLinkProcessor(),
  TutorialNavigationExtension(),
  TutorialStructureExtension(),
];
