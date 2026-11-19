// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:math' as math;

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:path/path.dart' as p;
import 'package:site_shared/image_dimensions.dart';

/// Populates intrinsic `width` and `height` HTML attributes on `<img>` nodes
/// that reference static files under the site's `web/` directory.
final class ImageDimensionProcessor implements PageExtension {
  const ImageDimensionProcessor({this.webRoot});

  /// Optional path to the site's `web/` directory for hermetic testing.
  final String? webRoot;

  @override
  Future<List<Node>> apply(Page page, List<Node> nodes) async {
    final root = webRoot ?? defaultDocsWebRoot();
    return _processNodes(nodes, root);
  }

  List<Node> _processNodes(List<Node> nodes, String root) => [
    for (final node in nodes) _processNode(node, root),
  ];

  Node _processNode(Node node, String root) {
    if (node is! ElementNode) return node;

    final children = node.children;
    final processedChildren = children == null
        ? null
        : _processNodes(children, root);

    if (node.tag.toLowerCase() != 'img') {
      return ElementNode(node.tag, node.attributes, processedChildren);
    }

    return ElementNode(
      node.tag,
      _resolveImgAttributes(node.attributes, root),
      processedChildren,
    );
  }
}

/// Resolves the `sites/docs/web` directory from either the site package root
/// or the workspace root.
String defaultDocsWebRoot() {
  if (Directory('web').existsSync()) return 'web';
  final workspaceDocsWeb = p.join('sites', 'docs', 'web');
  return Directory(workspaceDocsWeb).existsSync() ? workspaceDocsWeb : 'web';
}

/// Reads intrinsic dimensions for a site-root-relative [src] (such as
/// `/assets/images/docs/...`) from [webRoot].
ImageDimensions? resolveDocsWebImageDimensions(String src, {String? webRoot}) {
  if (!src.startsWith('/') || src.startsWith('//')) return null;
  final cleanPath = src.split('#').first.split('?').first;
  if (cleanPath.length <= 1) return null;

  final root = webRoot ?? defaultDocsWebRoot();
  final filePath = p.normalize(p.join(root, p.fromUri(cleanPath.substring(1))));
  return readImageDimensions(filePath);
}

/// Renders an `<img>` element for `sites/docs` with `width` and `height`
/// populated from [src] under `web/` when available.
Component docsSizedImg({
  required String src,
  required String alt,
  Map<String, String>? attributes,
}) {
  final dims = resolveDocsWebImageDimensions(src);
  return img(
    src: src,
    alt: alt,
    width: dims?.width,
    height: dims?.height,
    attributes: attributes,
  );
}

final RegExp _pixelDimensionPattern = RegExp(r'^([1-9]\d*)(?:px)?$');

int? _parsePixelDimension(String? raw) {
  if (raw == null) return null;
  final match = _pixelDimensionPattern.firstMatch(raw.trim());
  return match == null ? null : int.tryParse(match.group(1)!);
}

Map<String, String> _resolveImgAttributes(
  Map<String, String> attributes,
  String webRoot,
) {
  final src = attributes['src'];
  if (src == null) return attributes;

  final dims = resolveDocsWebImageDimensions(src, webRoot: webRoot);
  if (dims == null) return attributes;

  final rawWidth = attributes['width'];
  final rawHeight = attributes['height'];
  if (rawWidth != null && rawHeight != null) {
    final parsedW = _parsePixelDimension(rawWidth);
    final parsedH = _parsePixelDimension(rawHeight);
    if (parsedW != null && parsedH != null) {
      return {
        ...attributes,
        'width': '$parsedW',
        'height': '$parsedH',
      };
    }
    return attributes;
  }

  if (rawWidth == null && rawHeight == null) {
    return {
      ...attributes,
      'width': '${dims.width}',
      'height': '${dims.height}',
    };
  }

  if (rawWidth != null) {
    return _resolveWidthOnlyAttributes(attributes, rawWidth, dims);
  }
  return _resolveHeightOnlyAttributes(attributes, rawHeight!, dims);
}

Map<String, String> _resolveWidthOnlyAttributes(
  Map<String, String> attributes,
  String rawWidth,
  ImageDimensions dims,
) {
  final parsedW = _parsePixelDimension(rawWidth);
  if (parsedW != null) {
    final scaledH = math.max(1, (dims.height * parsedW / dims.width).round());
    return {
      ...attributes,
      'width': '$parsedW',
      'height': '$scaledH',
    };
  }

  return {
    ...attributes,
    'style': _appendCssDeclaration(attributes['style'], 'width: $rawWidth;'),
    'width': '${dims.width}',
    'height': '${dims.height}',
  };
}

Map<String, String> _resolveHeightOnlyAttributes(
  Map<String, String> attributes,
  String rawHeight,
  ImageDimensions dims,
) {
  final parsedH = _parsePixelDimension(rawHeight);
  if (parsedH != null) {
    final scaledW = math.max(1, (dims.width * parsedH / dims.height).round());
    return {
      ...attributes,
      'width': '$scaledW',
      'height': '$parsedH',
    };
  }

  return {
    ...attributes,
    'style': _appendCssDeclaration(attributes['style'], 'height: $rawHeight;'),
    'width': '${dims.width}',
    'height': '${dims.height}',
  };
}

String _appendCssDeclaration(String? existing, String declaration) {
  final trimmed = existing?.trim() ?? '';
  if (trimmed.isEmpty) return declaration;
  final normalized = trimmed.endsWith(';') ? trimmed : '$trimmed;';
  return '$normalized $declaration';
}
