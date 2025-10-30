---
title: Stack-based navigation
description: Learn how to navigate from one page to another in a Flutter app
permalink: /tutorial/stack-based-navigation/
sitemap: false
---

Now that you understand slivers and scrolling, you can implement
navigation between screens. In this lesson, you'll update the
small-screen view such that when a contact group is tapped, it
navigates to the contact list for that group.

First, revert changes in the adaptive layout widget so that it
displays the ContactGroupsPage by default on small screens.

```dart
// lib/screens/adaptive_layout.dart

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

## Add navigation to contact groups

The `ContactGroupsPage` already uses a `_ContactGroupsView`
and provides it with a callback. That callback needs to be updated to
navigate when a group is tapped, rather than printing the group to the
console.

Ensure that the `onListSelected` callback in
`lib/screens/contact_groups.dart` is implemented as follows:

```dart
// lib/screens/contact_groups.dart

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

`Navigator.of(context)` retrieves the nearest `Navigator` widget from
the widget tree. The `push` method adds a new route to the
navigator's stack, and displays the widget returned from the `builder` property.

This is the most basic implementation of using stack-based navigation,
where new screens are pushed on top of the current screen. To navigate
back to the previous screen, you'd use the `Navigator.pop` method.

`CupertinoPageRoute` creates iOS-style page transitions with the following features:
- A slide-in animation from the right.
- Automatic back button support.
- Proper title handling.
- Swipe-to-go-back gesture support.

## Create the sidebar component for large screens

For large screens, you need a sidebar that doesn't navigate but
instead updates the main content area. Thanks to the refactoring in
the previous step, creating this component is simple. Add this widget
to the bottom of `lib/screens/contact_groups.dart`:

```dart
// lib/screens/contact_groups.dart

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

This sidebar component reuses the `_ContactGroupsView` and provides a
different callback. Instead of navigating, it calls `onListSelected`
with the ID of the tapped list. It also passes the `selectedListId` to
`_ContactGroupsView` so that the selected item can be highlighted.

## Create the detail view for large screens

For the large screen layout, you need a detail view that doesn't show
navigation controls. Just like the sidebar, this is easy to create by
reusing the `_ContactListView`. Add this widget to the bottom of your
`contacts.dart` file:

```dart
// lib/screens/contacts.dart

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
`automaticallyImplyLeading: false` to hide the back button, as
navigation is handled by the sidebar.

## Connect the sidebar to the adaptive layout

Now, connect the sidebar to your adaptive layout. Update your
`adaptive_layout.dart` to import the necessary files and update the
large screen layout:

```dart
// lib/screens/adaptive_layout.dart
import 'package:flutter/cupertino.dart';
import 'package:rolodex/screens/contact_groups.dart';
import 'package:rolodex/screens/contacts.dart';
```

Then update the `_buildLargeScreenLayout` method:

```dart
// lib/screens/adaptive_layout.dart

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

## Test the adaptive navigation behavior

Hot reload your app and test the navigation:

**Small screens (< 600px width):**
- Tap contact groups to navigate to contact details.
- Use the back button or swipe gesture to return.
- This is a classic stack-based navigation flow.

**Large screens (> 600px width):**
- Click contact groups in the sidebar to update the detail view.
- There is no navigation stack. The selection updates the content area.
- This is a master-detail interface pattern.

The app automatically chooses the appropriate navigation pattern based
on screen size. This provides an optimal experience on both phones and
tablets.
