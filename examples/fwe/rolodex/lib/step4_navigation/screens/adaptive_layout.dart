// #docregion imports
import 'package:flutter/cupertino.dart';

import 'contact_groups.dart';
import 'contacts.dart';
// #enddocregion imports

const largeScreenMinWidth = 600;

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

// #docregion reverted-state
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
  // #enddocregion reverted-state

  // #docregion build_large_screen
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
            Container(width: 1, color: CupertinoColors.separator),
            Expanded(child: ContactListDetail(listId: selectedListId)),
          ],
        ),
      ),
    );
  }

  // #enddocregion build_large_screen
  // #docregion reverted-state
}

// #enddocregion reverted-state
