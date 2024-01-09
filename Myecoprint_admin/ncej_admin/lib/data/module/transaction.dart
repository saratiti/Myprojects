class Transaction {
  int storeId;
  int offerId;
  int points;
  String transactionType;
  DateTime transactionDate;

  Transaction({
    required this.storeId,
    required this.offerId,
    required this.points,
    required this.transactionType,
    required this.transactionDate,
  });

factory Transaction.fromJson(Map<String, dynamic> json) {
  return Transaction(
    storeId: json['store_id'] as int? ?? 0,
    offerId: json['offer_id'] as int? ?? 0,
    points: json['points'] as int? ?? 0,
    transactionType: json['transaction_type'] as String? ?? '',
    transactionDate: json['transaction_date'] != null
        ? DateTime.parse(json['transaction_date'].toString())
        : DateTime.now(),
  );
}
}
