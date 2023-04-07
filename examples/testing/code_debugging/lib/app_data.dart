// #docregion PassAppData
import 'dart:convert';
import 'dart:developer' as developer;

void main() {
  var myCustomObject = MyCustomObject();

  developer.log(
    'log me',
    name: 'my.app.category',
    error: jsonEncode(myCustomObject),
  );
}
// #enddocregion PassAppData

class MyCustomObject {}
