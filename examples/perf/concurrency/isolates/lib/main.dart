// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isolates demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Isolates demo')),
        body: const Center(
          child: ElevatedButton(
            onPressed: getPhotos,
            child: Text('Fetch photos'),
          ),
        ),
      ),
    );
  }
}

// #docregion isolate-run
// Produces a list of 211,640 photo objects.
// (The JSON file is ~20MB.)
Future<List<Photo>> getPhotos() async {
  final String jsonString = await rootBundle.loadString('assets/photos.json');
  final List<Photo> photos = await Isolate.run<List<Photo>>(() {
    final List<Object?> photoData = jsonDecode(jsonString) as List<Object?>;
    return photoData.cast<Map<String, Object?>>().map(Photo.fromJson).toList();
  });
  return photos;
}
// #enddocregion isolate-run

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> data) {
    return Photo(
      albumId: data['albumId'] as int,
      id: data['id'] as int,
      title: data['title'] as String,
      thumbnailUrl: data['thumbnailUrl'] as String,
    );
  }
}
