// Used to generate `generated_pigeon.dart` with:
// dart run pigeon --input lib/pigeon_source.dart --dart_out lib/generated_pigeon.dart

// #docregion Search
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
// #enddocregion Search
