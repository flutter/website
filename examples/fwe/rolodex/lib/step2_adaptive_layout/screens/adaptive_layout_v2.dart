import 'package:flutter/cupertino.dart';
import 'contact_groups.dart';

const largeScreenMinWidth = 600;

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({super.key});

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> {
  @override
  Widget build(BuildContext context) {
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
