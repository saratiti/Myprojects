class ResetPassword {
  int resetPasswordId;
  String pinCode;
  DateTime timestamp;
  int userId;

  ResetPassword({
    required this.resetPasswordId,
    required this.pinCode,
    required this.timestamp,
    required this.userId,
  });

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return ResetPassword(
      resetPasswordId: json['reset_password_id'],
      pinCode: json['pin_code'],
      timestamp: DateTime.parse(json['timestamp']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reset_password_id': resetPasswordId,
      'pin_code': pinCode,
      'timestamp': timestamp.toIso8601String(),
      'user_id': userId,
    };
  }
}
