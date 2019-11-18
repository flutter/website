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
        Spacer(flex: 1),
        BlueBox(),
        BlueBox(),
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
  
  if (row.mainAxisAlignment == MainAxisAlignment.spaceAround 
      || row.mainAxisAlignment == MainAxisAlignment.spaceBetween 
      || row.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
    _result(false, ['It\'s best to use MainAxisAlignment.start, MainAxisAlignment.end, or MainAxisAlignment.center to see how the SizedBox widgets work in a Row.']);
    return;
  }
  
  if (row.children.length != 5) {
    _result(false, ['What do you think would happen if you added another Spacer widget with a flex value of 1 between the second and third BlueBox widgets?']);
    return;
  }

  if (row.children[0] is! BlueBox ||
     row.children[1] is! Spacer ||
     row.children[2] is! BlueBox ||
     row.children[3] is! Spacer ||
     row.children[4] is! BlueBox) {
    _result(false, ['Not quite. Row should contain five children in this order: BlueBox, Spacer, BlueBox, Spacer, BlueBox.']);
    return;
  }
  
    final spacer = row.children[3] as Spacer;
  
    if (spacer.flex != 1) {
    _result(false, ['The Spacer class should have a flex equal to 1.']);
    return;
  }
  
  _result(true, ['Both Spacer widgets create equal amounts of space between all three BlueBox widgets.']);
}
{$ end test.dart $}
```
