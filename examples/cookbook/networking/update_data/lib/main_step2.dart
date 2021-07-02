import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// #docregion updateAlbum
Future<http.Response> updateAlbum(String title) {
  return http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}
// #enddocregion updateAlbum