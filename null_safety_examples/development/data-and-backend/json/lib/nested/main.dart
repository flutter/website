import 'address.dart';
import 'user.dart';

void exampleJson() {
  // #docregion print
  Address address = Address("My st.", "New York");
  User user = User("John", address);
  print(user.toJson());
  // #enddocregion print
}
