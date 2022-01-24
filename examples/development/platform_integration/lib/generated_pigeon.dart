// #docregion Search
import 'package:pigeon/pigeon.dart';

class SearchRequest {
<<<<<<< HEAD
  String query = '';
}

class SearchReply {
  String result = '';
=======
  String query = "";
}

class SearchReply {
  String result = "";
>>>>>>> flutter-main
}

@HostApi()
abstract class Api {
  Future search(SearchRequest request);
}
// #enddocregion Search
