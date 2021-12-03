import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Provides a top level scope for targeted actions.
///
/// Targeted actions are useful for making actions that are bound to children or
/// siblings of the focused widget available for invocation that wouldn't
/// normally be visible to a Shortcuts widget ancestor of the focused widget.
/// TargetedActionScope is used in place or in addition to the Shortcuts widget
/// that defines the key bindings for a subtree.
///
/// To use a targeted action, define this scope with a set of shortcuts that
/// should be active in this scope. Then, in a child widget of this one, define
/// a [TargetedActionBinding] with the actions that you wish to execute when the
/// binding is activated with the intent. If no action is defined for a scope
/// for that intent, then nothing happens.
class TargetedActionScope extends StatefulWidget {
  TargetedActionScope({Key? key, required this.child, required this.shortcuts})
      : super(key: key);

  final Widget child;
  final Map<LogicalKeySet, Intent> shortcuts;

  @override
  State<TargetedActionScope> createState() => _TargetedActionScopeState();
}

class _TargetedActionScopeState extends State<TargetedActionScope> {
  late _TargetedActionRegistry registry;
  Map<LogicalKeySet, Intent> mappedShortcuts = <LogicalKeySet, Intent>{};

  @override
  void initState() {
    super.initState();
    registry = _TargetedActionRegistry();
    mappedShortcuts = _buildShortcuts();
  }

  @override
  void didUpdateWidget(TargetedActionScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.shortcuts != widget.shortcuts) {
      mappedShortcuts = _buildShortcuts();
    }
  }

  Map<LogicalKeySet, Intent> _buildShortcuts() {
    Map<LogicalKeySet, Intent> mapped = <LogicalKeySet, Intent>{};
    for (final LogicalKeySet activator in widget.shortcuts.keys) {
      mapped[activator] = _TargetedIntent(widget.shortcuts[activator]!);
    }
    return mapped;
  }

  @override
  Widget build(BuildContext context) {
    return Provider<_TargetedActionRegistry>.value(
      value: registry,
      child: Shortcuts(
        shortcuts: mappedShortcuts,
        child: Actions(
          actions: <Type, Action<Intent>>{
            _TargetedIntent: _TargetedAction(registry),
          },
          child: widget.child,
        ),
      ),
    );
  }
}

/// A binding for use within a [TargetedActionScope].
///
/// Place an instance of this widget as a descendant of a [TargetedActionScope],
/// and optionally define any actions that should handle the intents with
/// bindings in the scope. Any actions defined in parents of this widget will
/// also be in the scope.
///
/// If more than one of these exists in the same [TargetedActionScope], then
/// each of the corresponding contexts will be searched for an action to fulfill
/// the intent. The first one to be found that fulfills the intent will have its
/// action invoked. The order duplicate bindings are searched in is stable with
/// respect to build order, but arbitrary.
// This is a stateful widget because we need to be able to implement deactivate.
class TargetedActionBinding extends StatefulWidget {
  TargetedActionBinding({Key? key, required this.child, this.actions})
      : super(key: key);

  final Widget child;
  final Map<Type, Action<Intent>>? actions;

  @override
  State<TargetedActionBinding> createState() => _TargetedActionBindingState();
}

class _TargetedActionBindingState extends State<TargetedActionBinding> {
  final GlobalKey _subtreeKey =
      GlobalKey(debugLabel: 'Targeted Action Binding');

  @override
  Widget build(BuildContext context) {
    Provider.of<_TargetedActionRegistry>(context).addTarget(_subtreeKey);
    Widget result = KeyedSubtree(
      key: _subtreeKey,
      child: this.widget.child,
    );
    if (widget.actions != null) {
      result = Actions(actions: widget.actions!, child: result);
    }
    return result;
  }

  @override
  void deactivate() {
    Provider.of<_TargetedActionRegistry>(context, listen: false)
        .targetKeys
        .remove(_subtreeKey);
    super.deactivate();
  }
}

// This is a registry that keeps track of the set of targets in the scope, and
// handles invoking them.
//
// It is found through a provider.
class _TargetedActionRegistry {
  _TargetedActionRegistry() : targetKeys = <GlobalKey>{};

  Set<GlobalKey> targetKeys;

  // Adds the given target key to the set of keys to check.
  void addTarget(GlobalKey target) {
    targetKeys.add(target);
  }

  bool isEnabled(Intent intent) {
    // Check each of the target keys to see if there's an action registered in
    // that context for the intent. If so, find out if it is enabled. It is
    // build-order dependent which action gets invoked if there are two contexts
    // tha support the action.
    for (GlobalKey key in targetKeys) {
      if (key.currentContext != null) {
        Action? foundAction =
            Actions.maybeFind<Intent>(key.currentContext!, intent: intent);
        if (foundAction != null && foundAction.isEnabled(intent)) {
          return true;
        }
      }
    }
    return false;
  }

  Object? invoke(Intent intent) {
    // Check each of the target keys to see if there's an action registered in
    // that context for the intent. If so, execute it and return the result. It
    // is build-order dependent which action gets invoked if there are two
    // contexts tha support the action.
    for (GlobalKey key in targetKeys) {
      if (key.currentContext != null) {
        if (Actions.maybeFind<Intent>(key.currentContext!, intent: intent) !=
            null) {
          return Actions.invoke(key.currentContext!, intent);
        }
      }
    }
    return null;
  }
}

// A wrapper intent class so that it can hold the "real" intent, and serve as a
// mapping type for the _TargetedAction.
class _TargetedIntent extends Intent {
  const _TargetedIntent(this.intent);

  final Intent intent;
}

// A special action class that invokes the intent tunneled into it via the
// _TargetedIntent.
class _TargetedAction extends Action<_TargetedIntent> {
  _TargetedAction(this.registry);

  final _TargetedActionRegistry registry;

  @override
  bool isEnabled(_TargetedIntent intent) {
    return registry.isEnabled(intent.intent);
  }

  @override
  Object? invoke(covariant _TargetedIntent intent) {
    registry.invoke(intent.intent);
  }
}
