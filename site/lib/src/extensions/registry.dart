// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr_content/jaspr_content.dart';

import 'attribute_processor.dart';
import 'code_block_processor.dart';
import 'glossary_link_processor.dart';
import 'header_extractor.dart';
import 'header_processor.dart';
import 'table_processor.dart';

/// A list of all node-processing, page extensions to applied to
/// content loaded with Jaspr Content.
const List<PageExtension> allNodeProcessingExtensions = [
  AttributeProcessor(),
  HeaderExtractorExtension(),
  HeaderWrapperExtension(),
  TableWrapperExtension(),
  CodeBlockProcessor(),
  GlossaryLinkProcessor(),
];
