import 'dart:typed_data';

class Invoice {
  final int invoiceId;
  final String uploadDate;
  String filePath;
  final int userId;
  List<Uint8List>? imageBytesList; // Define imageBytesList field

  Invoice({
    required this.invoiceId,
    required this.uploadDate,
    required this.filePath,
    required this.userId,
    this.imageBytesList, // Update field name
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceId: json['invoice_id'] as int? ?? 0,
      uploadDate: json['upload_date'] as String? ?? '',
      filePath: json['file_path'] as String? ?? '',
      userId: json['user_id'] as int? ?? 0,
    );
  }
}
