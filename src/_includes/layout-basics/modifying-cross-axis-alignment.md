```run-dartpad:theme-dark:mode-flutter:split-60:width-100%:height-400px
{$ begin main.dart $}
import 'package:flutter_web/material.dart';
import 'package:flutter_web_test/flutter_web_test.dart';
import 'package:flutter_web_ui/ui.dart' as ui;

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlueBox(),
        BiggerBlueBox(),
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

class BiggerBlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
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

  if (row.children.length != 3 || row.children.any((w) => w is! BlueBox && w is! BiggerBlueBox)) {
    _result(false, ['The Row should have three children, all BlueBox or BiggerBlueBox widgets.']);
    return;
  }

  if (row.crossAxisAlignment == CrossAxisAlignment.start) {
    _result(true, ['The BlueBox and BiggerBlueBox widgets are positioned at the top of the cross axis.']);
  } else if (row.crossAxisAlignment == CrossAxisAlignment.end) {
    _result(true, ['The BlueBox and BiggerBlueBox widgets are positioned at the bottom of the cross axis']);
  } else if (row.crossAxisAlignment == CrossAxisAlignment.center) {
    _result(false, ['The widgets are positioned at the middle of the cross axis. Change CrossAxisAlignment.center to CrossAxisAlignment.start.']);
  } else if (row.crossAxisAlignment == CrossAxisAlignment.stretch) {
    _result(true, ['The BlueBox and BiggerBlueBox widgets are stretched across the cross axis. Change the Row to a Column, and run again.']);
  } else if(row.crossAxisAlignment == CrossAxisAlignment.baseline) {
    _result(false, ['Couldn\t find a text class.']);
  }
}
{$ end test.dart $}
```
