
class Point {
  int pointId;
  int storeId;
  double? totalPoints;
  int reasonBarcodeId;
  int? userId;


  Point({
    required this.pointId,
    required this.storeId,
    this.totalPoints,
    required this.reasonBarcodeId,
    this.userId,

  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      pointId: json['point_id']as int? ??0,
      storeId: json['store_id']as int? ??0,
      totalPoints: json['total_points'] != null
          ? json['total_points'].toDouble()
          : null,
      reasonBarcodeId: json['reasonBarcode_id']as int? ??0,
      userId: json['user_id']as int? ??0,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'point_id': pointId,
      'store_id': storeId,
      'total_points': totalPoints,
      'reasonBarcode_id': reasonBarcodeId,
      'user_id': userId,
    
    };
  }
}
