import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

Future<void> loadData() async {
  var dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  http.Response response = await http.get(dataURL);
  developer.log(response.body);
}
