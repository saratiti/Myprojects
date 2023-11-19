class User {
 late int id;
  String username;
  String email;
  String? password;
  late String image;

  User({
    required this.username,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(username: json['username'], email: json['email'], image: '',);
  }
}