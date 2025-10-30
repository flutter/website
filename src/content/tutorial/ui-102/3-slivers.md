---
title: Advanced scrolling and slivers
description: Learn how to implement performant scrolling with slivers.
permalink: /tutorial/slivers/
sitemap: false
---

In this lesson, you'll learn about slivers, which are special widgets
that can take advantage of Flutter's powerful and composable scrolling
system. Slivers enable you to create sophisticated scroll effects,
including collapsible headers, search integration, and custom scroll
behaviors. By the end of this section, you'll understand how to use
`CustomScrollView`, create navigation bars that collapse, and organize
content in scrollable sections.

## Slivers and widgets

Slivers are scrollable areas that can be composed together in a
`CustomScrollView` or other scroll views. Think of slivers as
building blocks that each contribute a portion of the overall
scrollable content.

While slivers and widgets are both fundamental Flutter concepts, they
serve different purposes and aren't interchangeable.

- **Widgets** are general UI building blocks that can be used anywhere
  in your widget tree.
- **Slivers** are specialized widgets designed specifically for
  scrollable layouts and have some constraints:

- Slivers can **only** be direct children of scroll views, like
  `CustomScrollView` and `NestedScrollView`.
- Some scroll views **only** accept slivers as children. You can't
  pass regular widgets to `CustomScrollView.slivers`.
- To use regular widgets within a sliver context, wrap them in
  `SliverToBoxAdapter` or `SliverFillRemaining`.

This architectural separation allows Flutter to optimize scrolling
performance while it maintains clear boundaries between different
types of UI components.

## Add a basic sliver structure to contact groups

First, replace the placeholder content in your contact groups
page. To avoid duplicating code between the phone layout and the tablet
sidebar, you can create a private, reusable widget.

Update `lib/screens/contact_groups.dart` by adding `_ContactGroupsView` to the bottom of the file.

```dart
// lib/screens/contact_groups.dart

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

This private widget contains the shared UI for displaying the list of
contact groups. On small screens, it will be used as a page, and on
large screens it will be used to fill the left column.

This widget introduces several slivers:
- `CupertinoSliverNavigationBar`: An opinionated navigation bar that
  collapses as the page scrolls.
- `SliverList`: A scrollable list of items.
- `SliverFillRemaining`: A sliver that takes up the remaining space in
  the scroll area, and who's child is a non-sliver widget.



It takes a callback function, `onListSelected`, to handle
taps, which makes it adaptable for both navigation and sidebar selection.

Now, update `ContactGroupsPage` to use this new private widget:

```dart
// lib/screens/contact_groups.dart
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

This structure keeps the `ContactGroupsPage` clean and focused on its
primary responsibility: navigation, which you'll learn about in the
next section of this tutorial.

## Enhance the list with icons and visual elements

Now, add icons and contact counts to make the list more
informative. Add this helper method to your `_ContactGroupsView` class:

```dart
// In lib/screens/contact_groups.dart, inside _ContactGroupsView

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

This helper creates the trailing content for each list item. It shows
the contact count and a forward arrow.

Now, update the `CupertinoListSection` in `_ContactGroupsView` to use
icons and the trailing helper. Update the code within the
`ListenableBuilder.builder` callback in the `build` method.

```dart
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

                // New from here
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

The updated code now shows icons that differentiate between the main
"All iPhone" group and user-created groups, along with contact counts
and navigation indicators.

## Create advanced scrolling for contacts

Now, work on the contacts page. Just like before, you'll create a
private, reusable view to avoid code duplication.

In the next lesson, you'll implement navigation for small screens. To
see your progress on the contacts list page in the meantime, update
`AdaptiveLayout` to display the contacts list page.


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
          return const ContactsListPage(listId: 0); // New, temporary
        }
      },
    );
  }
}
```


Update `lib/screens/contacts.dart` by adding `_ContactListView` to the
bottom of the file:

```dart
// lib/screens/contacts.dart
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

```dart
// lib/screens/contacts.dart
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

## Add search integration with slivers

The `CupertinoSliverNavigationBar.search` constructor provides
integrated search functionality. As you scroll down, the search field
smoothly transitions into the collapsed navigation bar.

Now, enhance the contacts page with integrated search
functionality UI. Update the `CustomScrollView` in `_ContactListView`:

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
integrated search functionality. As you scroll down, the search field
smoothly transitions into the collapsed navigation bar.

## Create alphabetized contact sections

Real-world contact apps organize contacts alphabetically. To do this,
create sections for each letter. Add the following widget to the
bottom of your `contacts.dart` file. This widget doesn't contain any
slivers.

```dart
// lib/screens/contacts.dart

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

This widget creates the familiar alphabetized sections that you see in iOS
Contacts.

## Use `SliverList` for the alphabetized sections

Now, replace the placeholder content in `_ContactListView` with the
alphabetized sections:

```dart
// In lib/screens/contacts.dart, inside _ContactListView's builder

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

`SliverList.list` allows you to provide a list of widgets that become
part of the scrollable content. This is the simplest way to add a list
of normal widgets to scrollable sliver area.

In the next lesson, you'll learn about stack-based navigation and
update the UI on small screens to navigate between the contacts list
view and the contacts view.
