// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:build/build.dart';

import 'src/builders/styles_hash_builder.dart' show StylesHashBuilder;

Builder stylesHashBuilder(BuilderOptions _) => const StylesHashBuilder();
