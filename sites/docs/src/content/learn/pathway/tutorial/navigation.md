---
title: Stack-based navigation
description: Learn how to navigate from one page to another in a Flutter app.
layout: tutorial
---

Learn to navigate between screens with Navigator.push and implement adaptive navigation patterns for different screen sizes.

<SummaryCard>
title: What you'll accomplish
items:
  - title: Navigate between screens with Navigator.push
    icon: open_in_new
  - title: Use CupertinoPageRoute for iOS-style transitions
    icon: swipe_right
  - title: Create different navigation patterns for each screen size
    icon: devices
</SummaryCard>

---

### Introduction

Now that you understand slivers and scrolling,
you can implement navigation between screens.
In this lesson,
you'll update the small-screen view such that when a contact group is tapped,
it navigates to the contact list for that group.

First, revert changes in the adaptive layout widget so that it
displays the `ContactGroupsPage` by default on small screens.

```dart title="lib/screens/adaptive_layout.dart"
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
          return _buildLargeScreenLayout();
        } else {
          return const ContactGroupsPage(); // Reverted
        }
      },
    );
  }
}
```

### Add navigation to contact groups

The `ContactGroupsPage` already uses a `_ContactGroupsView`
and provides it with a callback.
That callback needs to be updated to navigate when a group is tapped,
rather than printing the group to the console.

Ensure that the `onListSelected` callback in
`lib/screens/contact_groups.dart` is implemented as follows:

```dart title="lib/screens/contact_groups.dart"
class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      onListSelected: (list) => Navigator.of(context).push(
        CupertinoPageRoute(
          title: list.title,
          builder: (context) => ContactListsPage(listId: list.id),
        ),
      ),
    );
  }
}
```

This small code block contains the most important new information on this page.

`Navigator.of(context)` retrieves the
nearest `Navigator` widget from the widget tree.
The `push` method adds a new route to the navigator's stack, and
displays the widget returned from the `builder` property.

This is the most basic implementation of using stack-based navigation,
where new screens are pushed on top of the current screen.
To navigate back to the previous screen, you'd use the `Navigator.pop` method.

`CupertinoPageRoute` creates iOS-style page transitions with
the following features:

- A slide-in animation from the right.
- Automatic back button support.
- Proper title handling.
- Swipe-to-go-back gesture support.

### Create the sidebar component for large screens

For large screens, you need a sidebar that doesn't navigate but
instead updates the main content area.
Thanks to the refactoring in the previous step,
creating this component is more straightforward.
Add this widget to the bottom of `lib/screens/contact_groups.dart`:

```dart title="lib/screens/contact_groups.dart"
// ...

/// A sidebar component for selecting contact groups, designed for large screens.
class ContactGroupsSidebar extends StatelessWidget {
  const ContactGroupsSidebar({
    super.key,
    required this.selectedListId,
    required this.onListSelected,
  });

  final int selectedListId;
  final Function(int) onListSelected;

  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: selectedListId,
      onListSelected: (list) => onListSelected(list.id),
    );
  }
}
```

This sidebar component reuses the `_ContactGroupsView` and
provides a different callback. Instead of navigating,
it calls `onListSelected` with the ID of the tapped list.
It also passes the `selectedListId` to `_ContactGroupsView` so that
the selected item can be highlighted.

### Create the detail view for large screens

For the large screen layout, you need a detail view that
doesn't show navigation controls. Just like the sidebar,
this can be recreated by reusing the `_ContactListView`.
Add this widget to the bottom of your `contacts.dart` file:

```dart title="lib/screens/contacts.dart"
// ...

/// A detail view component for showing contacts in a specific list.
class ContactListDetail extends StatelessWidget {
  const ContactListDetail({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return _ContactListView(
      listId: listId,
      automaticallyImplyLeading: false,
    );
  }
}
```

The detail view reuses `_ContactListView` and sets
the `automaticallyImplyLeading` parameter to `false` to
hide the back button, as navigation is handled by the sidebar.

### Connect the sidebar to the adaptive layout

Now, connect the sidebar to your adaptive layout.
Update your `adaptive_layout.dart` file to import the necessary files and
update the large screen layout:

```dart title="lib/screens/adaptive_layout.dart"
import 'package:flutter/cupertino.dart';
import 'package:rolodex/screens/contact_groups.dart';
import 'package:rolodex/screens/contacts.dart';
```

Then update the `_buildLargeScreenLayout` method:

```dart title="lib/screens/adaptive_layout.dart"
Widget _buildLargeScreenLayout() {
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.extraLightBackgroundGray,
    child: SafeArea(
      child: Row(
        children: [
          SizedBox(
            width: 320,
            child: ContactGroupsSidebar(
              selectedListId: selectedListId,
              onListSelected: _onContactListSelected,
            ),
          ),
          Container(
            width: 1,
            color: CupertinoColors.separator,
          ),
          Expanded(
            child: ContactListDetail(listId: selectedListId),
          ),
        ],
      ),
    ),
  );
}
```

This code creates the classic menu-detail layout where the sidebar
controls the content of the detail area.

### Test the adaptive navigation behavior

Hot reload your app and test the navigation:

**Small screens (<600px width):**

- Tap contact groups to navigate to contact details.
- Use the back button or a swipe gesture to return.
- This is a classic stack-based navigation flow.

**Large screens (>600px width):**

- Click contact groups in the sidebar to update the detail view.
- There is no navigation stack. The selection updates the content area.
- This is a master-detail interface pattern.

The app automatically chooses the
appropriate navigation pattern based on screen size.
This provides an optimal experience on both phones and tablets.

### Review


<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you built and learned in this lesson.
completed: true
items:
  - title: Navigated between screens with Navigator.push
    icon: open_in_new
    details: >-
      `Navigator.of(context).push` adds a new route to the navigation stack.
      This is the foundation of stack-based navigation, where screens are
      pushed on top of each other and popped to go back.
  - title: Used CupertinoPageRoute for iOS-style transitions
    icon: swipe_right
    details: >-
      `CupertinoPageRoute` provides support for native iOS navigation features:
      slide-in animations from the right, automatic back buttons,
      proper title handling, and swipe-to-go-back gesture support.
  - title: Implemented adaptive navigation patterns
    icon: devices
    details: >-
      You set up different navigation patterns for small and large screens.
      Small screens use stack-based navigation where
      tapping a group pushes a new screen.
      Large screens use a master-detail pattern where selecting
      a group updates the detail panel without navigation.
  - title: Completed the Rolodex app
    icon: celebration
    details: >-
      You've built a complete iOS-style contacts app with
      adaptive layouts, advanced scrolling,
      collapsible headers with search, and responsive navigation.
      These are common patterns used in production apps!
</SummaryCard>

### Test yourself

<Quiz title="Navigation Quiz">
- question: "What does `Navigator.of(context).push` do?"
  options:
    - text: Replaces the current screen with a new one.
      correct: false
      explanation: "Push adds to the stack; `pushReplacement` replaces the current screen."
    - text: Adds a new route to the navigation stack, displaying it on top of the current screen.
      correct: true
      explanation: Push adds the new route to the stack, allowing users to go back to the previous screen.
    - text: Removes the current screen from the navigation stack.
      correct: false
      explanation: "That's what `pop` does; push adds a new screen."
    - text: Opens a dialog box over the current screen.
      correct: false
      explanation: "Dialogs use `showDialog`; Navigator.push navigates to a full screen."
- question: "What does `Navigator.of(context).pop()` do?"
  options:
    - text: Closes the entire app.
      correct: false
      explanation: Pop only removes the current route; it doesn't close the app.
    - text: Removes the current route from the navigation stack, returning to the previous screen.
      correct: true
      explanation: Pop removes the top route from the stack, revealing the screen beneath it.
    - text: Clears all routes and shows the home screen.
      correct: false
      explanation: That would require popUntil or pushAndRemoveUntil; pop removes only the top route.
    - text: Refreshes the current screen with new data.
      correct: false
      explanation: Pop navigates back; to refresh, you'd use setState or other state management.
</Quiz>
