// ignore_for_file: avoid_print

// #docregion use-api
import 'generated_pigeon.dart';

Future<void> onClick() async {
  SearchRequest request = SearchRequest(query: 'test');
  Api api = SomeApi();
  SearchReply reply = await api.search(request);
  print('reply: ${reply.result}');
}
// #enddocregion use-api

class SomeApi extends Api {}
