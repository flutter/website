import 'dart:async';

import 'package:http/http.dart' as http;

// #docregion fetchPhotos
Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get(Uri.https('jsonplaceholder.typicode.com', 'photos'));
}
// #enddocregion fetchPhotos
