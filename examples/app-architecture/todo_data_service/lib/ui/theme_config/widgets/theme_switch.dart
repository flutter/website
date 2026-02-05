import 'package:flutter/material.dart';
import '../viewmodel/theme_switch_viewmodel.dart';

// #docregion ThemeSwitch
class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key, required this.viewmodel});

  final ThemeSwitchViewModel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Text('Dark Mode'),
          ListenableBuilder(
            listenable: viewmodel,
            builder: (context, _) {
              return Switch(
                value: viewmodel.isDarkMode,
                onChanged: (_) {
                  viewmodel.toggle.execute();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// #enddocregion ThemeSwitch
