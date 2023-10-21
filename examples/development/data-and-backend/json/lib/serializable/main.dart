import 'dart:convert';

import 'user.dart';

const jsonString = '''
{
  "name": "John Smith",
  "email": "john@example.com"
}
''';

void exampleJson() {
  // #docregion fromJson
  final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final user = User.fromJson(userMap);
  // #enddocregion fromJson

  print('Howdy, ${user.name}!');
  print('We sent the verification link to ${user.email}.');

  // #docregion jsonEncode
  // ignore: unused_local_variable
  String json = jsonEncode(user);
  // #enddocregion jsonEncode
}
