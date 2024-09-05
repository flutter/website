import 'dart:convert';

import 'user.dart';

const jsonString = '''
{
  "name": "John Smith",
  "email": "john@example.com"
}
''';

void exampleJson() {
  // #docregion from-json
  final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final user = User.fromJson(userMap);
  // #enddocregion from-json

  print('Howdy, ${user.name}!');
  print('We sent the verification link to ${user.email}.');

  // #docregion json-encode
  // ignore: unused_local_variable
  String json = jsonEncode(user);
  // #enddocregion json-encode
}
