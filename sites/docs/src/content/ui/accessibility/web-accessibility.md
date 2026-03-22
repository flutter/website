---
title: Web accessibility
description: Information about web accessibility
---

## Background

Flutter supports web accessibility by translating its internal
Semantics tree into an accessible HTML DOM structure that
screen readers can understand.
Since Flutter renders its UI on a single canvas, it needs a special layer
to expose the UI's meaning and structure to web browsers.


## Opt-in web accessibility

### Invisible button

For performance reasons, Flutter's web accessibility is not on by default.
To turn on accessibility, the user needs to press an invisible button with
`aria-label="Enable accessibility"`.
After pressing the button, the DOM tree will reflect all accessibility
information for the widgets.

### Turn on accessibility mode in code

An alternative approach is to turn on accessibility mode
by adding the following code when running an app.

```dart
import 'package:flutter/semantics.dart';

void main() {
  runApp(const MyApp());
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
}
```



## Enhancing Accessibility with Semantic Roles

### What are Semantic Roles?

Semantic roles define the purpose of a UI element, helping screen readers
and other assistive tools interpret and present your application effectively
to users. For example, a role can indicate if a widget is a button, a link,
to users. For example, a role can indicate whether a widget is a button, a link,
a heading, a slider, or part of a table.

While Flutter's standard widgets often provide these semantics automatically,
a custom component without a clearly defined role can be incomprehensible
to a screen reader user.


By assigning appropriate roles, you ensure that:

* Screen readers can announce the type and purpose of elements correctly.
* Users can navigate your application more effectively using assistive technologies.
* Your application adheres to web accessibility standards, improving usability.

### Using `SemanticsRole` in Flutter for web

Flutter provides the [`Semantics` widget][] with the [`SemanticsRole` enum][]
to allow developers to assign specific roles to their widgets. When your
Flutter web app is rendered, these Flutter-specific roles are translated into
corresponding ARIA roles in the web page's HTML structure.

[`Semantics` widget]: {{site.api}}/flutter/widgets/Semantics-class.html
[`SemanticsRole` enum]: {{site.api}}/flutter/dart-ui/SemanticsRole.html

**1. Automatic Semantics from Standard Widgets**

Many standard Flutter widgets, like `TabBar`, `MenuAnchor`, and `Table`,
automatically include semantic information along with their roles.
Whenever possible, prefer using these standard widgets
as they handle many accessibility aspects out-of-the-box.

**2. Explicitly adding or overriding roles**

For custom components or when the default semantics aren't sufficient,
use the `Semantics` widget to define the role:

Here's an example of how you might explicitly define a list and its items:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';


class MyCustomListWidget extends StatelessWidget {
  const MyCustomListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This example shows how to explicitly assign list and listitem roles
    // when building a custom list structure.
    return Semantics(
      role: SemanticsRole.list,
      explicitChildNodes: true,
      child: Column(
        children: <Widget>[
          Semantics(
            role: SemanticsRole.listItem,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Content of the first custom list item.'),
            ),
          ),
          Semantics(
            role: SemanticsRole.listItem,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Content of the second custom list item.'),
            ),
          ),
        ],
      ),
    );
  }
}
```
