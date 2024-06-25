class ChallengeType {
  final int id;
  final String typeName;
  final int requiredCount;
  final int points;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ChallengeType({
    required this.id,
    required this.typeName,
    required this.requiredCount,
    required this.points,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ChallengeType.fromJson(Map<String, dynamic> json) {
    return ChallengeType(
      id: json['id'] ?? 0,
      typeName: json['type_name'] ?? '',
      requiredCount: json['required_count'] ?? 0,
      points: json['points'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }
}
