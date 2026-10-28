// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

/// Tools for optimizing the media of websites, such as by
/// converting PNG and JPEG images to WebP with a pinned,
/// checksum-verified build of Google's `cwebp` encoder.
library;

export 'src/cwebp.dart' show CwebpException;
export 'src/image_optimizer.dart'
    show ImageOptimization, ImageOptimizer, validateImagePaths;
export 'src/webp_converter.dart'
    show
        WebpConversionResult,
        WebpConverted,
        WebpFailed,
        WebpSkipReason,
        WebpSkipped;
