import 'package:flutter/material.dart';

import 'app_localizations.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // #docregion access-string
    Text(AppLocalizations.of(context)!.hello('John'));
    // #enddocregion access-string
  }
}
