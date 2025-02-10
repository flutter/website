class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      email = json['email'] as String;

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}
