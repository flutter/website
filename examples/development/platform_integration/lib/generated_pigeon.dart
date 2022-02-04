// #docregion Search
import 'package:pigeon/pigeon.dart';

class SearchRequest {
  String query = '';
}

class SearchReply {
  String result = '';
}

@HostApi()
abstract class Api {
  Future search(SearchRequest request);
}
// #enddocregion Search
