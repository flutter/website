import 'dart:async';

import 'package:http/http.dart' as http;

// #docregion fetchPhoto
Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
}
// #enddocregion fetchPhoto
