```run-dartpad:theme-dark:mode-flutter:split-60:width-100%:height-400px
{$ begin main.dart $}
import 'package:flutter_web/material.dart';
import 'package:flutter_web_test/flutter_web_test.dart';
import 'package:flutter_web_ui/ui.dart' as ui;

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlueBox(),
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
  
  if (row.children.length != 3 || row.children.any((w) => w is! BlueBox)) {
    _result(false, ['The Row should have three children, all BlueBox widgets.']);
    return;
  }

  if (row.mainAxisAlignment == MainAxisAlignment.start) {
    _result(false, ['MainAxisAlignment.start positions the BlueBox widgets on the left of the main axis. Change the value to MainAxisAlignment.end.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.end) {
    _result(true, ['MainAxisAlignment.end positions the BlueBox widgets on the right of the main axis.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.center) {
    _result(true, ['MainAxisAlignment.center positions the BlueBox widgets at the middle of the main axis.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.spaceBetween) {
    _result(true, ['The extra space is divided between the BlueBox widgets.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
    _result(true, ['The extra space is divided evenly between the BlueBox widgets and before and after them.']);
  } else if (row.mainAxisAlignment == MainAxisAlignment.spaceAround) {
    _result(true, ['Similar to MainAxisAlignment.spaceEvenly, but reduces half of the space before the first BlueBox widget and after the last BlueBox widget to half of the width between the BlueBox widgets.']);
  }  
}
{$ end test.dart $}
```
