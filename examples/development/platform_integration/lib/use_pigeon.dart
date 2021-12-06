// ignore_for_file: avoid_print

// #docregion UseApi
import 'generated_pigeon.dart';

void onClick() async {
  SearchRequest request = SearchRequest()..query = 'test';
  Api api = SomeApi();
  SearchReply reply = await api.search(request);
  print('reply: ${reply.result}');
}
// #enddocregion UseApi

class SomeApi extends Api {
  @override
  Future search(SearchRequest request) {
    return Future(() => {SearchReply});
  }
}
