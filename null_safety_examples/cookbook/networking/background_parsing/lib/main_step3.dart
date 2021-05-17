import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// #docregion parsePhotos
// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody) as List;
  return [for (final json in parsed) Photo.fromJson(json)];
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/photos');
  final response = await client.get(uri);

  return parsePhotos(response.body);
}
// #enddocregion parsePhotos

// #docregion Photo
@immutable
class Photo {
  final int albumId, id;
  final String title, url, thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, Object?> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

// #enddocregion Photo
