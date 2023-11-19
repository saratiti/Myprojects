class Register{
  late int id;
  String username;
  String email;
  String password;
  String ?image;


  Register({
    this.image,
    required this.username,
    required this.email,
    required this.password,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      username: json['username'],
      email: json['email'],
      password: json['password'],
     
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}