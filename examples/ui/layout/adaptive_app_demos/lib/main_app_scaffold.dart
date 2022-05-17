import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';
import 'global/device_size.dart';
import 'global/device_type.dart';
import 'global/targeted_actions.dart';
import 'pages/adaptive_data_table_page.dart';
import 'pages/adaptive_grid_page.dart';
import 'pages/adaptive_reflow_page.dart';
import 'pages/focus_examples_page.dart';
import 'pages/login_page.dart';
import 'widgets/app_title_bar.dart';
import 'widgets/buttons.dart';
import 'widgets/ok_cancel_dialog.dart';

List<Widget> getMainMenuChildren(BuildContext context) {
  // Define a method to change pages in the AppModel
  void changePage(int value) => context.read<AppModel>().selectedIndex = value;
  int index = context.select<AppModel,int>((m) => m.selectedIndex);
  return [
    SelectedPageButton(
        onPressed: () => changePage(0),
        label: 'Adaptive Grid',
        isSelected: index == 0),
    SelectedPageButton(
        onPressed: () => changePage(1),
        label: 'Adaptive Data Table',
        isSelected: index == 1),
    SelectedPageButton(
        onPressed: () => changePage(2),
        label: 'Adaptive Reflow',
        isSelected: index == 2),
    SelectedPageButton(
        onPressed: () => changePage(3),
        label: 'Focus Examples',
        isSelected: index == 3),
  ];
}

// Uses a tab navigation + drawer,  or a side-menu that combines both
class MainAppScaffold extends StatefulWidget {
  @override
  _MainAppScaffoldState createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool useTabs = MediaQuery.of(context).size.width < FormFactor.tablet;
    bool isLoggedOut = context.select<AppModel,bool>((m) => m.isLoggedIn) == false;
    return TargetedActionScope(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.control):
            SelectAllIntent(),
        LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.control):
            SelectNoneIntent(),
        LogicalKeySet(LogicalKeyboardKey.delete): DeleteIntent(),
      },
      child: WindowBorder(
        color: Colors.white,
        child: Material(
          child: Column(
            children: [
              AppTitleBar(),
              Expanded(
                child: isLoggedOut
                    // If logged out, show just the login page with no menus
                    ? LoginPage()
                    // Otherwise, show the full application with dynamic scaffold
                    : Focus(
                        autofocus: true,
                        child: Scaffold(
                          key: _scaffoldKey,
                          drawer: useTabs
                              ? _SideMenu(showPageButtons: false)
                              : null,
                          appBar: useTabs
                              ? AppBar(backgroundColor: Colors.blue.shade300)
                              : null,
                          body: Stack(children: [
                            // Vertical layout with Tab controller and drawer
                            if (useTabs) ...[
                              Column(
                                children: [
                                  Expanded(child: _PageStack()),
                                  _TabMenu(),
                                ],
                              )
                            ]
                            // Horizontal layout with desktop style side menu
                            else ...[
                              Row(
                                children: [
                                  _SideMenu(),
                                  Expanded(child: _PageStack()),
                                ],
                              ),
                            ],
                          ]),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = context.select<AppModel,int>((model) => model.selectedIndex);
    Widget? page;
    if (index == 0) page = AdaptiveGridPage();
    if (index == 1) page = AdaptiveDataTablePage();
    if (index == 2) page = AdaptiveReflowPage();
    if (index == 3) page = FocusExamplesPage();
    return FocusTraversalGroup(child: page ?? Container());
  }
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({Key? key, this.showPageButtons = true}) : super(key: key);

  final bool showPageButtons;

  @override
  Widget build(BuildContext context) {
    Future<void> _handleLogoutPressed() async {
      String message = 'Are you sure you want to logout?';
      bool? doLogout = await showDialog(
          context: context, builder: (_) => OkCancelDialog(message: message));
      if (doLogout ?? false) {
        context.read<AppModel>().logout();
      }
    }

    return Container(
      color: Colors.white,
      width: 250,
      child: Stack(
        children: [
          // Buttons
          Column(children: [
            SizedBox(height: Insets.extraLarge),
            if (showPageButtons) ...getMainMenuChildren(context),
            SizedBox(height: Insets.extraLarge),
            SecondaryMenuButton(label: 'Submenu Item 1'),
            SecondaryMenuButton(label: 'Submenu Item 2'),
            SecondaryMenuButton(label: 'Submenu Item 3'),
            Spacer(),
            OutlinedButton(
                child: Text('Logout'), onPressed: _handleLogoutPressed),
            SizedBox(height: Insets.large),
          ]),
          // Divider
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: 1, height: double.infinity, color: Colors.blue)),
        ],
      ),
    );
  }
}

class _TabMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap all the main menu buttons in Expanded() so they fill up the screen horizontally
    List<Expanded> tabButtons = getMainMenuChildren(context)
        .map((btn) => Expanded(child: btn))
        .toList();
    return Column(
      children: [
        // Top Divider
        Container(width: double.infinity, height: 1, color: Colors.blue),
        // Tab buttons
        Row(children: tabButtons),
      ],
    );
  }
}
