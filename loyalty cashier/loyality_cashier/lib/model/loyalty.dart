class Loyalty {
  int? loyaltyId; 
  int? loyaltyPoint;
  String? loyaltyLevel;
  DateTime? lastActivityDate;
  int? userId;

  Loyalty({
    this.loyaltyId,
    this.loyaltyPoint,
    this.loyaltyLevel,
    this.lastActivityDate,
    this.userId,
  });

  factory Loyalty.fromJson(Map<String, dynamic> json) {
    return Loyalty(
      loyaltyId: json['loyality_id'] as int?,
      loyaltyPoint: json['loyalty_point'] as int?,
      loyaltyLevel: json['loyalty_level'] as String?,
      lastActivityDate: json['last_activity_date'] != null
          ? DateTime.parse(json['last_activity_date'] as String)
          : null,
      userId: json['user_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'loyality_id': loyaltyId?.toString(),
      'loyalty_point': loyaltyPoint?.toString(),
      'loyalty_level': loyaltyLevel,
      'last_activity_date': lastActivityDate?.toIso8601String(),
      'user_id': userId?.toString(),
    };
  }
}
