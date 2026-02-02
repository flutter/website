---
title: Advanced scrolling and slivers
description: Learn how to implement performant scrolling with slivers.
layout: tutorial
---

In this lesson, you'll learn about slivers,
which are special widgets that can take advantage of
Flutter's powerful and composable scrolling system.
Slivers enable you to create sophisticated scroll effects,
including collapsible headers, search integration, and custom scroll behaviors.
By the end of this section, you'll understand how to
use `CustomScrollView`, create navigation bars that collapse,
and organize content in scrollable sections.

<SummaryCard>
title: What you'll accomplish
items:
  - title: Understand slivers and how they differ from widgets
    icon: view_day
  - title: Build scrollable layouts with CustomScrollView
    icon: unfold_more
  - title: Create collapsible navigation bars with search
    icon: search
  - title: Organize contacts in alphabetized sections
    icon: sort_by_alpha
</SummaryCard>

---

### Slivers and widgets

Slivers are scrollable areas that can be composed together in a
`CustomScrollView` or other scroll views.
Think of slivers as building blocks that each
contribute a portion of the overall scrollable content.

While slivers and widgets are both fundamental Flutter concepts,
they serve different purposes and aren't interchangeable.

- **Widgets** are general UI building blocks that
  can be used anywhere in your widget tree.
- **Slivers** are specialized widgets designed specifically for
  scrollable layouts and have some constraints:

- Slivers can **only** be direct children of scroll views, such as
  `CustomScrollView` and `NestedScrollView`.
- Some scroll views **only** accept slivers as children.
  You can't pass regular widgets to `CustomScrollView.slivers`.
- To use regular widgets within a sliver context,
  wrap them in `SliverToBoxAdapter` or `SliverFillRemaining`.

This architectural separation allows Flutter to
optimize scrolling performance while it maintains clear boundaries between
different types of UI components.

### Add a basic sliver structure to contact groups

First, replace the placeholder content in your contact groups page.
To avoid duplicating code between the phone layout and the tablet sidebar,
you can create a private, reusable widget.

Update `lib/screens/contact_groups.dart` by
adding `_ContactGroupsView` to the bottom of the file.

```dart title="lib/screens/contact_groups.dart"
// New imports
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';

// ... ContactGroupsPage widget ...

// New
class _ContactGroupsView extends StatelessWidget {
  const _ContactGroupsView({
    required this.onListSelected,
    this.selectedListId,
  });

  final int? selectedListId;
  final Function(ContactGroup) onListSelected;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Lists'),
          ),
          SliverFillRemaining(
            child: ValueListenableBuilder<List<ContactGroup>>(
              valueListenable: contactGroupsModel.listsNotifier,
              builder: (context, contactLists, child) {
                return CupertinoListSection.insetGrouped(
                  header: const Text('iPhone'),
                  children: [
                    for (final ContactGroup contactList in contactLists)
                      CupertinoListTile(
                        title: Text(contactList.label),
                        onTap: () => onListSelected(contactList),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

This private widget contains the shared UI for
displaying the list of contact groups.
On small screens, it will be used as a page, and on
large screens it will be used to fill the left column.

This widget introduces several slivers:

- `CupertinoSliverNavigationBar`:
  An opinionated navigation bar that collapses as the page scrolls.
- `SliverList`:
  A scrollable list of items.
- `SliverFillRemaining`:
  A sliver that takes up the remaining space in
  the scroll area, and whose child is a non-sliver widget.

It accepts a callback function, `onListSelected`, to handle taps,
which makes it adaptable for both navigation and sidebar selection.

Now, update `ContactGroupsPage` to use your new `_ContactGroupsView` widget:

```dart title="lib/screens/contact_groups.dart"
class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: 0,
      onListSelected: (list) {
        // TODO: Implement navigation lesson.
        debugPrint(list.toString());
      },
    );
  }
}
// ... _ContactGroupsView from above
```

This structure keeps the `ContactGroupsPage` clean and
focused on its primary responsibility: navigation,
which you'll learn about in the next section of this tutorial.

### Enhance the list with icons and visual elements

Now, add icons and contact counts to make the list more informative.
Add this `_buildTrailing` helper method to your `_ContactGroupsView` class:

```dart title="lib/screens/contact_groups.dart"
// Inside _ContactGroupsView:

Widget _buildTrailing(List<Contact> contacts, BuildContext context) {
  final TextStyle style = CupertinoTheme.of(
    context,
  ).textTheme.textStyle.copyWith(color: CupertinoColors.systemGrey);

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(contacts.length.toString(), style: style),
      const Icon(
        CupertinoIcons.forward,
        color: CupertinoColors.systemGrey3,
        size: 18,
      ),
    ],
  );
}
```

This helper creates the trailing content for each list item.
It shows the contact count and a forward arrow.

Now, update the `CupertinoListSection` in `_ContactGroupsView` to
use icons and the trailing helper. Update the code within the
`ListenableBuilder.builder` callback in the `build` method:

```dart title="lib/screens/contact_groups.dart"
import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';

class ContactGroupsPage extends StatelessWidget {
  const ContactGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ContactGroupsView(
      selectedListId: 0,
      onListSelected: (list) {
        // TODO: Implement navigation lesson.
        debugPrint(list.toString());
      },
    );
  }
}

class _ContactGroupsView extends StatelessWidget {
  const _ContactGroupsView({
    required this.onListSelected,
    this.selectedListId,
  });

  final int? selectedListId;
  final Function(ContactGroup) onListSelected;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Lists'),
          ),
          SliverFillRemaining(
            child: ValueListenableBuilder<List<ContactGroup>>(
              valueListenable: contactGroupsModel.listsNotifier,
              builder: (context, contactLists, child) {

                // New from here:
                const groupIcon = Icon(
                  CupertinoIcons.group,
                  weight: 900,
                  size: 32,
                );

                const pairIcon = Icon(
                  CupertinoIcons.person_2,
                  weight: 900,
                  size: 24,
                );

                return CupertinoListSection.insetGrouped(
                  header: const Text('iPhone'),
                  children: [
                    for (final ContactGroup contactList in contactLists)
                      CupertinoListTile(
                        leading: contactList.id == 0 ? groupIcon : pairIcon,
                        title: Text(contactList.label),
                        trailing: _buildTrailing(contactList.contacts, context),
                        onTap: () => onListSelected(contactList),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing(List<Contact> contacts, BuildContext context) {
    //...
  }
}
```

The updated code now shows icons that differentiate between the
main "All iPhone" group and user-created groups, along with
contact counts and navigation indicators.

### Create advanced scrolling for contacts

Now, work on the contacts page. Just like before,
you'll create a private, reusable view to avoid code duplication.

In the next lesson, you'll implement navigation for small screens.
To see your progress on the contacts list page in the meantime,
update `AdaptiveLayout` to display the contacts list page:

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
          return const ContactsListPage(listId: 0); // New, temporary
        }
      },
    );
  }
}
```

Update `lib/screens/contacts.dart` by adding `_ContactListView` to
the bottom of the file:

```dart title="lib/screens/contacts.dart"
class _ContactListView extends StatelessWidget {
  const _ContactListView({
    required this.listId,
    this.automaticallyImplyLeading = true,
  });

  final int listId;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<List<ContactGroup>>(
        valueListenable: contactGroupsModel.listsNotifier,
        builder: (context, contactGroups, child) {
          final ContactGroup contactList =
              contactGroupsModel.findContactList(listId);

          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(contactList.title),
                automaticallyImplyLeading: automaticallyImplyLeading,
              ),
              SliverFillRemaining(
                child: Center(
                  child: Text(
                      '${contactList.contacts.length} contacts in ${contactList.label}'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

Now, update `ContactListsPage` to use this view:

```dart title="lib/screens/contacts.dart"
import 'package:flutter/cupertino.dart';
import 'package:rolodex/data/contact_group.dart';
import 'package:rolodex/main.dart';

class ContactListsPage extends StatelessWidget {
  const ContactListsPage({super.key, required this.listId});

  final int listId;

  @override
  Widget build(BuildContext context) {
    return _ContactListView(listId: listId);
  }
}

// ... _ContactListView from above.
```

This basic implementation demonstrates how to use slivers with dynamic
data in a reusable component.

### Add search integration with slivers

Now, enhance the contacts page with integrated search functionality UI.
Update the `CustomScrollView` in `_ContactListView` to use the
`CupertinoSliverNavigationBar.search` constructor instead of the
default `CupertinoSliverNavigationBar` constructor:

```dart
class _ContactListView extends StatelessWidget {
  const _ContactListView({
    required this.listId,
  });

  final int listId;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<List<ContactGroup>>(
        valueListenable: contactGroupsModel.listsNotifier,
        builder: (context, contactGroups, child) {
          final ContactGroup contactList = contactGroupsModel.findContactList(
            listId,
          );

          return CustomScrollView(
            slivers: [
              // New
              CupertinoSliverNavigationBar.search(
                largeTitle: Text(contactList.title),
                searchField: const CupertinoSearchTextField(
                  suffixIcon: Icon(CupertinoIcons.mic_fill),
                  suffixMode: OverlayVisibilityMode.always,
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    '${contactList.contacts.length} contacts in ${contactList.label}',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

```

The `CupertinoSliverNavigationBar.search` constructor provides
integrated search functionality. As you scroll down,
the search field smoothly transitions into the collapsed navigation bar.

### Create alphabetized contact sections

Real-world contact apps organize contacts alphabetically.
To do this, create sections for each letter.
Add the following widget to the bottom of your `contacts.dart` file.
This widget doesn't contain any slivers.

```dart title="lib/screens/contacts.dart"
// ...

class ContactListSection extends StatelessWidget {
  const ContactListSection({
    super.key,
    required this.lastInitial,
    required this.contacts,
  });

  final String lastInitial;
  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              lastInitial,
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CupertinoListSection(
            backgroundColor: CupertinoColors.systemBackground,
            dividerMargin: 0,
            additionalDividerMargin: 0,
            topMargin: 4,
            children: [
              for (final Contact contact in contacts)
                CupertinoListTile(
                  padding: EdgeInsets.all(0),
                  title: Text('${contact.firstName} ${contact.lastName}'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
```

This widget creates the familiar alphabetized sections that
you see in the iOS Contacts app.

### Use `SliverList` for the alphabetized sections

Now, replace the placeholder content in `_ContactListView` with
the alphabetized sections:

```dart title="lib/screens/contacts.dart"
// Inside _ContactListView's builder:

final AlphabetizedContactMap contacts = contactList.alphabetizedContacts;

return CustomScrollView(
  slivers: [
    CupertinoSliverNavigationBar.search(
      largeTitle: Text(contactList.title),
      automaticallyImplyLeading: automaticallyImplyLeading,
      searchField: const CupertinoSearchTextField(
        suffixIcon: Icon(CupertinoIcons.mic_fill),
        suffixMode: OverlayVisibilityMode.always,
      ),
    ),
    SliverList.list(
      children: [
        const SizedBox(height: 20),
        ...contacts.keys.map(
          (String initial) => ContactListSection(
            lastInitial: initial,
            contacts: contacts[initial]!,
          ),
        ),
      ],
    ),
  ],
);
```

`SliverList.list` allows you to provide a list of widgets that
become part of the scrollable content. This is the simplest way to
add a list of normal widgets to a scrollable sliver area.

In the next lesson, you'll learn about stack-based navigation and
update the UI on small screens to navigate between
the contacts list view and the contacts view.

### Review

<SummaryCard>
title: What you accomplished
subtitle: Here's a summary of what you built and learned in this lesson.
completed: true
items:
  - title: Understood slivers and how they differ from widgets
    icon: view_day
    details: >-
      Slivers are specialized widgets for scrollable layouts.
      They can only be direct children of scroll views like `CustomScrollView`.
      In `CustomScrollView` and other sliver contexts, regular widgets must be
      wrapped in `SliverToBoxAdapter` or `SliverFillRemaining`.
  - title: Built scrollable layouts with CustomScrollView
    icon: unfold_more
    details: >-
      `CustomScrollView` lets you compose multiple slivers together.
      You used `CupertinoSliverNavigationBar`, `SliverFillRemaining`,
      and `SliverList` to create sophisticated scrollable interfaces.
  - title: Created collapsible navigation bars with search
    icon: search
    details: >-
      You used the `CupertinoSliverNavigationBar.search` constructor to
      create a collapsible navigation bar with integrated search functionality.
  - title: Organized contacts in alphabetized sections
    icon: sort_by_alpha
    details: >-
      You created `ContactListSection` widgets grouped by last name initial,
      then used `SliverList.list` to add them to the scrollable area.
      This mirrors the familiar iOS Contacts app experience.
</SummaryCard>

### Test yourself

<Quiz title="Slivers Quiz">
- question: What is the key difference between slivers and regular widgets?
  options:
    - text: Slivers are faster to render than regular widgets.
      correct: false
      explanation: Both are optimized; the difference is their purpose and context.
    - text: Slivers are specialized widgets designed for scrollable layouts and can only be direct children of scroll views.
      correct: true
      explanation: Slivers work within scroll views like CustomScrollView; regular widgets can be used anywhere.
    - text: Slivers can have an unlimited number of children.
      correct: false
      explanation: Some slivers like SliverList can have many children, but that's not what distinguishes them.
    - text: Slivers automatically handle user gestures.
      correct: false
      explanation: Gesture handling is separate; slivers are about scrollable layout composition.
- question: How do you use a regular widget inside a CustomScrollView's slivers list?
  options:
    - text: Just add it directly; CustomScrollView accepts any widget.
      correct: false
      explanation: CustomScrollView only accepts slivers; regular widgets must be wrapped.
    - text: Wrap it in a SliverToBoxAdapter or SliverFillRemaining.
      correct: true
      explanation: These adapters convert regular widgets into slivers so they can be used in sliver contexts.
    - text: "Convert the widget to a sliver by calling `.toSliver()` on it."
      correct: false
      explanation: "There's no `.toSliver()` method; you use adapter widgets like SliverToBoxAdapter."
    - text: "Pass it to the `child` property instead of `slivers`."
      correct: false
      explanation: CustomScrollView uses the slivers property; there's no child property for this purpose.
</Quiz>
