class Login {
  final String accessToken;

  Login({
    required this.accessToken,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      accessToken: json['accessToken'],
    );
  }
}
