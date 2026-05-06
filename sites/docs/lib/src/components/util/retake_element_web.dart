// Copyright 2025 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/client.dart';
// ignore: implementation_imports
import 'package:jaspr/src/dom/type_checks.dart';
import 'package:universal_web/web.dart' as web;

/// Retakes the element matching [predicate] during hydration.
web.Element? retakeElement(
  BuildContext context,
  bool Function(web.Element element) predicate,
) {
  final r = (context as Element).parentRenderObjectElement?.renderObject;
  if (r == null) return null;
  final node = (r as DomRenderObject).retakeNode((node) {
    return node.isElement && predicate(node as web.Element);
  });
  return node as web.Element?;
}

Component wrapNode(web.Node node) {
  return RawNode(node);
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
