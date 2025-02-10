// Used to generate `generated_pigeon.dart` with:
// ignore_for_file: one_member_abstracts
// dart run pigeon --input lib/pigeon_source.dart --dart_out lib/generated_pigeon.dart

// #docregion search
import 'package:pigeon/pigeon.dart';

class SearchRequest {
  final String query;

  SearchRequest({required this.query});
}

class SearchReply {
  final String result;

  SearchReply({required this.result});
}

@HostApi()
abstract class Api {
  @async
  SearchReply search(SearchRequest request);
}

// #enddocregion search
