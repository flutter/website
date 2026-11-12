// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

import '../../../util.dart';
import '../../common/button.dart';
import '../../common/material_icon.dart';

/// An interactive stepper component that displays a sequence of steps with
/// expand/collapse transitions and step navigation.
@client
class InteractiveStepper extends StatefulComponent {
  /// Creates an interactive stepper with the given [titles] and [steps].
  const InteractiveStepper({
    required this.titles,
    required this.steps,
    this.collapsible = true,
    this.showActions = true,
    this.showFinish = true,
    super.key,
  }) : assert(steps.length > 0, 'Stepper must have at least one step.'),
       assert(titles.length == steps.length, 'Titles must match step count.');

  /// The title component for each step.
  final List<Component> titles;

  /// The content component for each step.
  final List<Component> steps;

  /// Whether the stepper steps can be collapsed and expanded.
  final bool collapsible;

  /// Whether to show action buttons (such as "Continue") at the end of
  /// each step.
  final bool showActions;

  /// Whether to show a "Finish" action button on the final step.
  final bool showFinish;

  @override
  State<InteractiveStepper> createState() => _InteractiveStepperState();
}

class _InteractiveStepperState extends State<InteractiveStepper> {
  int openStep = 0;
  List<GlobalNodeKey<web.HTMLElement>> _titleKeys = [];

  @override
  void initState() {
    super.initState();
    _titleKeys = List.generate(component.titles.length, (_) => GlobalNodeKey());
    if (kIsWeb) {
      context.binding.addPostFrameCallback(_updatePageHeading);
    }
  }

  void _updatePageHeading() {
    if (!component.collapsible || openStep == -1) return;

    final title = _titleKeys[openStep].currentNode?.textContent;
    if (title != null) {
      currentPageHeading.value = title;
    }
  }

  void _toggleStep(int index, web.ToggleEvent event) {
    if (event.newState == 'open') {
      if (openStep == index) return;
      setState(() => openStep = index);
      _updatePageHeading();
    } else if (event.newState == 'closed') {
      if (openStep != index) return;
      setState(() => openStep = -1);
    }
  }

  void _goToStep(int index) {
    if (openStep != -1) {
      _scrollTo(openStep, smooth: false);
    }

    if (index + 1 < component.steps.length) {
      setState(() => openStep = index + 1);
      _updatePageHeading();
      context.binding.addPostFrameCallback(() {
        _scrollTo(openStep, smooth: true);
      });
    } else {
      setState(() => openStep = -1);
    }
  }

  void _scrollTo(int index, {required bool smooth}) {
    final element = _titleKeys[index].currentNode;
    if (element == null) return;

    // Scroll the next step into view, accounting for the fixed header and toc.
    final headerOffset =
        web.document.getElementById('site-header')?.clientHeight ?? 0;
    final tocOffset = web.document.getElementById('pagenav')?.clientHeight ?? 0;
    final elementPosition = element.getBoundingClientRect().top;
    const padding = 20;
    final offsetPosition =
        elementPosition +
        web.window.scrollY -
        headerOffset -
        tocOffset -
        padding;

    web.window.scrollTo(
      web.ScrollToOptions(
        top: offsetPosition,
        behavior: smooth ? 'smooth' : 'auto',
      ),
    );
  }

  @override
  Component build(BuildContext context) {
    assert(component.steps.isNotEmpty, 'Stepper must have at least one step.');

    final stepperClasses = component.collapsible
        ? 'stepper'
        : 'stepper non-collapsible';

    return div(classes: stepperClasses, [
      for (final (index, step) in component.steps.indexed)
        details(
          open: !component.collapsible || index == openStep,
          events: component.collapsible
              ? {'toggle': (e) => _toggleStep(index, e as web.ToggleEvent)}
              : null,

          [
            summary([
              span(
                classes: 'step-number',
                attributes: {'aria-label': 'Step ${index + 1}'},
                [.text('${index + 1}')],
              ),
              div(key: _titleKeys[index], classes: 'step-title', [
                component.titles[index],
              ]),
              const MaterialIcon('keyboard_arrow_up'),
            ]),
            div(classes: 'step-content', [step]),
            if (component.showActions &&
                (index < component.steps.length - 1 || component.showFinish))
              div(classes: 'step-actions', [
                Button(
                  classes: const ['next-step-button'],
                  style: ButtonStyle.filled,
                  content: index == component.steps.length - 1
                      ? 'Finish'
                      : 'Continue',
                  onClick: () {
                    _goToStep(index);
                  },
                ),
              ]),
          ],
        ),
    ]);
  }
}
