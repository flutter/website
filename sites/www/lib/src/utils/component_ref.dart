// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nanoid2/nanoid2.dart';

import 'retake_element.dart';

/// A wrapper around [Component] to make it usable across server/client boundaries.
///
/// This is a temporary (and limited) solution until server components have
/// landed in Jaspr. They enable passing components to @client components
/// directly, by creating a unique ID on the server and retaking the dom node
/// on the client.
///
/// On the server, wrap your component with `context.ref(yourComponent)`, and
/// pass the resulting [ComponentRef] to your @client component.
/// On the client, retrieve the original component by calling `myRef.component`.
class ComponentRef extends StatelessComponent {
  const ComponentRef._(this.id, [this.component = const .empty()]);

  final String id;
  final Component component;

  @override
  Component build(BuildContext context) {
    if (!kIsWeb) {
      final scope =
          context
                  .getElementForInheritedComponentOfExactType<
                    ComponentRefScope
                  >()
              as _ComponentRefScopeElement?;
      assert(scope != null, 'No ComponentRefScope found in context');
      scope!.register(id, component);

      return Component.fragment([
        RawText('<!--ref:$id-->'),
        component,
        RawText('<!--/ref:$id-->'),
      ]);
    }

    return retakeRef(context, id);
  }

  @decoder
  factory ComponentRef.fromId(String id) {
    return ComponentRef._(id);
  }

  @encoder
  String toId() => id;
}

ComponentRef ref(Component child) {
  return ComponentRef._(nanoid(length: 8), child);
}

/// A scope for registering and retrieving component references.
///
/// This should wrap your entire app, typically in `main.dart`.
class ComponentRefScope extends InheritedComponent {
  const ComponentRefScope({required super.child});

  @override
  bool updateShouldNotify(ComponentRefScope oldComponent) {
    return false;
  }

  @override
  InheritedElement createElement() => _ComponentRefScopeElement(this);
}

class _ComponentRefScopeElement extends InheritedElement {
  _ComponentRefScopeElement(ComponentRefScope super.component);

  final Map<String, Component> _registeredComponents = {};

  Component getComponentById(String id) {
    final component = _registeredComponents[id];
    assert(component != null, 'No component registered with id "$id"');
    return component!;
  }

  void register(String id, Component child) {
    _registeredComponents[id] = child;
  }
}
