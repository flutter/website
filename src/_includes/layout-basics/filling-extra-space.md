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
  
  if (row.children.length != 3) {
    _result(false, ['The Row should have three children, all BlueBox widgets.']);
    return;
  }

   if (row.children[0] is! BlueBox) {
    _result(false, ['The Row\'s first child should be a BlueBox widget.']);
    return;
  }

  if (row.children[1] is! Expanded) {
    _result(false, ['Notice how Row contains extra space on its main axis. Wrap the second BlueBox widget in an Expanded widget.']);
    return;
  }

  if (row.children[2] is! BlueBox) {
    _result(false, ['The Row\'s third child should be a Flexible widget.']);
    return;
  }
  
  _result(true, ['Expanded forces second BlueBox widget to fill the extra space.']);
}
{$ end test.dart $}
```
