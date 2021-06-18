import 'dart:async';

import 'package:http/http.dart' as http;

// #docregion fetchAlbum
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}
// #enddocregion fetchAlbum
