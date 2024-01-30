class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // #docregion AccessString
        Text(AppLocalizations.of(context)!.hello('John'));
    // #enddocregion AccessString
  }
}
