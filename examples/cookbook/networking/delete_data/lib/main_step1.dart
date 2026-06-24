import 'dart:async';

import 'package:http/http.dart' as http;

// #docregion deleteAlbum
Future<http.Response> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
// #enddocregion deleteAlbum
