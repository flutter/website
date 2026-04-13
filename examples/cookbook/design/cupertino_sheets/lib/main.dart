import 'package:flutter/cupertino.dart';

void main() => runApp(const CupertinoSheetDemo());

// #docregion CupertinoSheetDemo
class CupertinoSheetDemo extends StatelessWidget {
  const CupertinoSheetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'CupertinoSheet Demo',
      home: CupertinoSheetPage(),
    );
  }
}
// #enddocregion CupertinoSheetDemo

class CupertinoSheetPage extends StatelessWidget {
  const CupertinoSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoSheet Demo'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () {
            // #docregion ShowCupertinoSheet
            showCupertinoSheet(
              context: context,
              scrollableBuilder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 100),
                        const Text('This is a Cupertino sheet'),
                        const SizedBox(height: 20),
                        CupertinoButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            // #enddocregion ShowCupertinoSheet
          },
          child: const Text('Show Sheet'),
        ),
      ),
    );
  }
}
