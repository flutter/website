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

  final columns = controller.widgetList(find.byType(Column));

  if (columns.length == 0) {
    _result(false, ['The Row contains three BlueBox widgets and lays them out horizontally.']);
    return;
  }

  if (columns.length > 1) {
    _result(false, ['Found ${columns.length} Rows, rather than just one.']);
    return;
  }

  final column = columns.first as Column;

  if (column.children.length != 3 || column.children.any((w) => w is! BlueBox)) {
    _result(false, ['Row/Column should contain three children, all BlueBox widgets.']);
    return;
  }

  _result(true, ['The Column contains three BlueBox widgets and lays them out vertically.']);
}
{$ end test.dart $}
```
