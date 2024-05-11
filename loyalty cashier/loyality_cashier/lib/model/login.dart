class Login {
  final String accessToken;
  final int userId;


  Login({
    required this.accessToken,
    required this.userId,
  });

  factory Login.fromJson(Map<String, dynamic> json, {required int userId}) {
    return Login(
      accessToken: json['accessToken'],
      userId:userId
    );
  }
}
