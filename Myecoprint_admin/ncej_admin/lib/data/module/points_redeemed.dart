class PointRedemption {
  int redemptionId;
  int userId;
  int storeId;
  int offerId;
  int pointsRedeemed;
  DateTime redemptionDate;

  PointRedemption({
    required this.redemptionId,
    required this.userId,
    required this.storeId,
    required this.offerId,
    required this.pointsRedeemed,
    required this.redemptionDate,
  });

  factory PointRedemption.fromJson(Map<String, dynamic> json) {
    return PointRedemption(
      redemptionId: json['redemption_id']as int? ?? 0,
      userId: json['user_id']as int? ?? 0,
      storeId: json['store_id']as int? ?? 0,
      offerId: json['offer_id']as int? ?? 0,
      pointsRedeemed: json['points_redeemed']as int? ?? 0,
      redemptionDate: DateTime.parse(json['redemption_date']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'redemption_id': redemptionId.toString(),
      'user_id': userId.toString(),
      'store_id': storeId.toString(),
      'offer_id': offerId.toString(),
      'points_redeemed': pointsRedeemed.toString(),
      'redemption_date': redemptionDate.toIso8601String(),
    };
  }
}
