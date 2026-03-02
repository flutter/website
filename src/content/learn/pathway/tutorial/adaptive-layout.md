---
title: LayoutBuilder and adaptive layouts
description: Learn how to use the LayoutBuilder widget.
layout: tutorial
---

Learn how to create layouts that adapt to different screen widths.

<SummaryCard>
title: What you'll accomplish
items:
  - title: Create responsive layouts with LayoutBuilder
    icon: fit_screen
  - title: Detect screen size to choose different layouts
    icon: devices
  - title: Build a sidebar and detail layout for large screens
    icon: view_sidebar
</SummaryCard>

---

### Introduction

Modern apps need to work well on screens of all sizes.
On this page, you'll learn how to create layouts that
adapt to different screen widths.
This app shows a sidebar on large screens and
a navigation-based UI on small screens.
Specifically, this app handles two screen sizes:

- **Large screens (tablets, desktop)**:
  Shows contact groups and contact details side-by-side.
- **Small screens (phones)**:
  Uses navigation to move between contact groups and details.

### Create the contact groups page

First, create the basic structure of the `ContactGroupsPage` widget
for your contact groups screen.
Create `lib/screens/contact_groups.dart` and add
the following basic structure:

```dart
import 'package:flutter/cupertino.dart';

class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: Center(
        child: Text('Contact Groups will go here'),
      ),
    );
  }
}
```

### Create the contacts page

Similarly, create `lib/screens/contacts.dart` to eventually
display individual contacts:

```dart
import 'package:flutter/cupertino.dart';

class ContactListsPage extends StatelessWidget {
  const ContactListsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: Center(
        child: Text('Lists of contacts will go here'),
      ),
    );
  }
}
```

The `ContaactsListPage` widget and `ContactGroupsPage` widget are
placeholder pages that are needed to implement the adaptive layout
widget, which you'll do next.

### Build the adaptive layout foundation

Create `lib/screens/adaptive_layout.dart`
and start with the following basic structure:

```dart
import 'package:flutter/cupertino.dart';

import 'contact_groups.dart';

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  @override
  Widget build(BuildContext context) {
    return const ContactGroupsPage(); // Temporary placeholder
  }
}

```

This is a `StatefulWidget` because the adaptive layout eventually
manages which contact group is currently selected.

Next, add the screen size detection logic:

```dart
import 'package:flutter/cupertino.dart';
import 'contact_groups.dart';

// New
const largeScreenMinWidth = 600;

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  @override
  Widget build(BuildContext context) {
    // Replace from here
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > largeScreenMinWidth;

        if (isLargeScreen) {
          return const Text('Large screen layout'); // Temporary
        } else {
          return const ContactGroupsPage();
        }
      },
    );
  }
}
```

The `LayoutBuilder` widget provides information about
the parent's size constraints.
In the `builder` callback, you receive a`BoxConstraints` object that
tells you the maximum available width and height.

By checking if `constraints.maxWidth > largeScreenMinWidth`,
you can decide which layout to show.
The 600-pixel threshold is a common breakpoint that
separates phone-sized screens from tablet-sized screens.

### Update the main app

Update `main.dart` to use the adaptive layout,
so you can see your changes:

```dart
import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/screens/adaptive_layout.dart';

final contactGroupsModel = ContactGroupsModel();

void main() {
  runApp(const RolodexApp());
}

class RolodexApp extends StatelessWidget {
  const RolodexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Rolodex',
      theme: CupertinoThemeData(
        barBackgroundColor: CupertinoDynamicColor.withBrightness(
          color: Color(0xFFF9F9F9),
          darkColor: Color(0xFF1D1D1D),
        ),
      ),
      home: AdaptiveLayout(), // New
    );
  }
}
```

If you're running in Chrome, you can resize the browser window to
see layout changes.

### Add list selection functionality

The large screen layout needs to track which contact group is selected.
Update the state object with the following code:

```dart
import 'package:flutter/cupertino.dart';

import 'contact_groups.dart';

const largeScreenMinWidth = 600;

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  // New
  int selectedListId = 0;

  // New
  void _onContactListSelected(int listId) {
    setState(() {
      selectedListId = listId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > largeScreenMinWidth;

        if (isLargeScreen) {
          return const Text('Large screen layout');
        } else {
          return const ContactGroupsPage();
        }
      },
    );
  }
}
```

The `selectedListId` variable tracks the currently selected contact group,
and `_onContactListSelected` updates this value when the user makes a choice.

### Build the large screen layout

Now, implement the side-by-side layout for large screens.
First, replace the temporary text with a widget that
contains the proper layout.

```dart
import 'package:flutter/cupertino.dart';

import 'contact_groups.dart';

const largeScreenMinWidth = 600;

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  int selectedListId = 0;

  void _onContactListSelected(int listId) {
    setState(() {
      selectedListId = listId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > largeScreenMinWidth;

        if (isLargeScreen) {
          return _buildLargeScreenLayout(); // New
        } else {
          // For small screens, use the original, navigation-style approach.
          return const ContactGroupsPage();
        }
      },
    );
  }

  // New
  Widget _buildLargeScreenLayout() {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: SafeArea(
        child: Row(
          children: [
            // Contact groups list:
            Text('Sidebar'),
            // List detail view:
            Text('Details'),
          ],
        ),
      ),
    );
  }
}
```

The large screen layout uses a `Row` to
place the sidebar and details side-by-side.
`SafeArea` ensures that the content doesn't overlap with
system UI elements like the status bar.

Now, set the sizes of the two panels and add a visual divider:

```dart
Widget _buildLargeScreenLayout() {
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.extraLightBackgroundGray,
    child: SafeArea(
      child: Row(
        children: [
          // Contact groups list:
          SizedBox(
            width: 320,
            child: Text('Sidebar placeholder'), // Temporary
          ),
          // Divider:
          Container(
            width: 1,
            color: CupertinoColors.separator,
          ),
          // List detail view:
          Expanded(
            child: Text('Details placeholder'), // Temporary
          ),
        ],
      ),
    ),
  );
}
```

This layout creates the following:

- A fixed-width sidebar (320 pixels) for contact groups.
- A 1-pixel divider between the panels.
- A details panel that uses an `Expanded` widget to take the remaining space.

### Test the adaptive layout

Hot reload your app and test the responsive behavior.
If you're running in Chrome, you can resize the browser window to
see the layout change:

- **Wide window (> 600px)**:
  Shows placeholder text for the sidebar and details side-by-side.
- **Narrow window (< 600px)**:
  Shows only the contact groups page.

Both the sidebar and main content area show placeholder text for now.

In the next lesson, you'll implement slivers to fill in
the contact list content.

### Review

<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you built and learned in this lesson.
completed: true
items:
  - title: Created responsive layouts with LayoutBuilder
    icon: fit_screen
    details: >-
      `LayoutBuilder` provides the parent's size constraints in
      its builder callback. By checking `constraints.maxWidth`,
      you can decide which layout to show based on available space.
  - title: Detected screen size to choose different layouts
    icon: devices
    details: >-
      You used a 600-pixel breakpoint to
      distinguish phone-sized screens from tablet-sized screens.
      This common threshold helps your app adapt its UI to
      provide the best experience on each device.
  - title: Built a sidebar and detail layout for large screens
    icon: view_sidebar
    details: >-
      On large screens, you displayed a fixed-width sidebar and
      an `Expanded` detail panel side-by-side using a `Row`.
      This classic pattern maximizes screen real estate on tablets and desktops.
</SummaryCard>

### Test yourself

<Quiz title="Adaptive Layout Quiz">
- question: What information does LayoutBuilder provide to its builder callback?
  options:
    - text: The device's operating system and screen orientation.
      correct: false
      explanation: LayoutBuilder provides size constraints, not OS or orientation info.
    - text: The parent's size constraints, including maximum width and height.
      correct: true
      explanation: LayoutBuilder's builder receives BoxConstraints that tell you the available space from the parent.
    - text: The current theme colors and typography.
      correct: false
      explanation: Theme data comes from Theme.of(context), not LayoutBuilder.
    - text: The number of child widgets in the tree.
      correct: false
      explanation: LayoutBuilder provides layout constraints, not widget tree information.
- question: In a large screen layout, which widget can be used to place a sidebar and details panel side-by-side?
  options:
    - text: Column
      correct: false
      explanation: Column arranges widgets vertically, not side-by-side.
    - text: Row
      correct: true
      explanation: Row arranges its children horizontally, making it ideal for placing a sidebar and details panel side-by-side.
    - text: Stack
      correct: false
      explanation: Stack overlaps widgets on top of each other, not side-by-side.
    - text: ListView
      correct: false
      explanation: ListView is for scrollable lists, not for side-by-side layout.
</Quiz>
