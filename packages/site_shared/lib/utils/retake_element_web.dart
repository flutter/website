// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/client.dart';
// ignore: implementation_imports
import 'package:jaspr/src/dom/type_checks.dart';
import 'package:universal_web/web.dart' as web;

/// Retakes the element with the specified [id] ref during hydration.
Component retakeRef(BuildContext context, String id) {
  final r = (context as Element).parentRenderObjectElement?.renderObject;
  if (r == null) return const .empty();

  var node = (r as DomRenderObject).retakeNode((node) {
    return node.isComment && (node as web.Comment).data.startsWith('ref:$id');
  });

  if (node == null) return const .empty();

  final nodes = <web.Node>[node];

  node = node.nextSibling;
  while (node != null) {
    r.retakeNode((n) => n == node);
    nodes.add(node);

    if (node.isComment && (node as web.Comment).data.startsWith('/ref:$id')) {
      break;
    }

    node = node.nextSibling;
  }

  return .fragment([
    for (final node in nodes) RawNode(node),
  ]);
}

class RawNode extends Component {
  RawNode(this.node, {super.key});

  final web.Node node;

  @override
  Element createElement() => _RawNodeElement(this);
}

class _RawNodeElement extends LeafRenderObjectElement {
  _RawNodeElement(RawNode super.component);

  @override
  RawNode get component => super.component as RawNode;

  @override
  void update(RawNode newComponent) {
    assert(
      newComponent.node == component.node,
      'RawNode cannot be updated with a different node. '
      'Use a new RawNode instance instead.',
    );
    super.update(newComponent);
  }

  @override
  RenderObject createRenderObject() {
    final parent = parentRenderObjectElement!.renderObject;
    return _DomRenderNode(component.node)..parent = parent as DomRenderObject;
  }

  @override
  void updateRenderObject(RenderObject renderObject) {}
}

class _DomRenderNode extends DomRenderObject {
  _DomRenderNode(this.node);

  @override
  final web.Node node;

  @override
  void attach(covariant RenderObject child, {covariant RenderObject? after}) {
    throw UnsupportedError('Raw nodes cannot have children attached to them.');
  }

  @override
  void remove(covariant RenderObject child) {
    throw UnsupportedError(
      'Text nodes cannot have children removed from them.',
    );
  }

  @override
  void finalize() {}

  @override
  web.Node? retakeNode(bool Function(web.Node node) visitNode) {
    return null; // Not applicable for raw nodes.
  }
}
