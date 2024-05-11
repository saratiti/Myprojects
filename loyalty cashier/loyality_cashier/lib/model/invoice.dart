import 'dart:typed_data';

class Invoice {
  final int invoiceId;
  final String uploadDate;
  String filePath;
  final int userId;
  final double totalAmount; 
  List<Uint8List>? imageBytesList; 

  Invoice({
    required this.invoiceId,
    required this.uploadDate,
    required this.filePath,
    required this.userId,
    required this.totalAmount,
    this.imageBytesList, 
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json['invoice_id'] as int? ?? 0,
      uploadDate: json['upload_date'] as String? ?? '',
      filePath: json['file_path'] as String? ?? '',
      userId: json['user_id'] as int? ?? 0,
       totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
