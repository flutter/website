import 'dart:async';

import 'package:http/http.dart' as http;

// #docregion fetchPhotos
Future<http.Response> fetchPhotos(http.Client client) async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/photos');
  final response = await client.get(uri);
}
// #enddocregion fetchPhotos
