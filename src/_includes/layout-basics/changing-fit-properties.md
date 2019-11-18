```run-dartpad:theme-dark:mode-flutter:split-60:width-100%:height-400px
{$ begin main.dart $}
import 'package:flutter_web/material.dart';
import 'package:flutter_web_test/flutter_web_test.dart';
import 'package:flutter_web_ui/ui.dart' as ui;

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlueBox(),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: BlueBox(),
        ),
        Flexible(
          fit: FlexFit.loose,
          flex: 1,
          child: BlueBox(),
        ),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
{$ end main.dart $}

{$ begin test.dart $}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Color(0xffeeeeee),
        child: Center(
          child: Container(
            child: MyWidget(),
            color: Color(0xffcccccc),
          ),
        ),
      ),
    );
  }
}

Future<void> main() async {
  await ui.webOnlyInitializePlatform();
  
  runApp(MyApp());

  final controller = LiveWidgetController(WidgetsBinding.instance);

  final rows = controller.widgetList(find.byType(Row));

  if (rows.length == 0) {
    _result(false, ['Couldn\'t find a Row!']);
    return;
  }

  if (rows.length > 1) {
    _result(false, ['Found ${rows.length} Rows, rather than just one.']);
    return;
  }

  final row = rows.first as Row;

  if (row.mainAxisSize != MainAxisSize.max) {
    _result(false, ['It\'s best to leave the mainAxisSize set to MainAxisSize.max, so there\'s space for the alignments to take effect.']);
    return;
  }
  
  if (row.children.length != 3) {
    _result(false, ['The Row should have three children, all BlueBox or Flexible widgets.']);
    return;
  }

  if (row.children[0] is! BlueBox) {
    _result(false, ['Row\'s first child should be a BlueBox.']);
    return;
  }

  if (row.children[1] is! Flexible) {
    _result(false, ['Row\'s second child should be a Flexible class.']);
    return;
  }

  if (row.children[2] is! Flexible) {
    _result(false, ['Row\'s third child should be a Flexible class.']);
    return;
  }

  final flexibleWidget = row.children[2] as Flexible;
  
  if (flexibleWidget.child == null || flexibleWidget.child is! BlueBox) {
    _result(false, ['The Flexible classes should have BlueBox widgets as their children.']);
    return;
  }

  if (flexibleWidget.fit != FlexFit.tight) {
    _result(false, ['The fit properties set the Flexible widgets to their preferred size. Change both fit values to FlexFit.tight.']);
    return;
  }

  _result(true, ['The Flexible widgets now occupy the space determined by their flex values.']);
}
{$ end test.dart $}
```
