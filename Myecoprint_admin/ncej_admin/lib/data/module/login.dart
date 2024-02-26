class Login {
  final String accessToken;
  final int companyId;

  Login({
    required this.accessToken,
    required this.companyId,
  });

  factory Login.fromJson(Map<String, dynamic> json, {required int companyId}) {
    return Login(
      accessToken: json['accessToken'],
      companyId: companyId,
    );
  }
}
