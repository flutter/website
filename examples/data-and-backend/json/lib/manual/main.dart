import 'dart:convert';

import 'user.dart';

// #docregion multiline-json
const jsonString = '''
{
  "name": "John Smith",
  "email": "john@example.com"
}
''';
// #enddocregion multiline-json

void example() {
  // #docregion manual
  final user = jsonDecode(jsonString) as Map<String, dynamic>;

  print('Howdy, ${user['name']}!');
  print('We sent the verification link to ${user['email']}.');
  // #enddocregion manual
}

void exampleJson() {
  // #docregion from-json
  final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final user = User.fromJson(userMap);

  print('Howdy, ${user.name}!');
  print('We sent the verification link to ${user.email}.');
  // #enddocregion from-json

  // #docregion json-encode
  // ignore: unused_local_variable
  String json = jsonEncode(user);
  // #enddocregion json-encode
}
