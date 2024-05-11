class Transaction {

  int points;
  String transactionType;
  DateTime transactionDate;

  Transaction({
   
    required this.points,
    required this.transactionType,
    required this.transactionDate,
  });

factory Transaction.fromJson(Map<String, dynamic> json) {
  return Transaction(
  
    points: json['points'] as int? ?? 0,
    transactionType: json['transaction_type'] as String? ?? '',
    transactionDate: json['transaction_date'] != null
        ? DateTime.parse(json['transaction_date'].toString())
        : DateTime.now(),
  );
}
}
