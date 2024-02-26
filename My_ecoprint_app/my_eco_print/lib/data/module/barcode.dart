import 'dart:typed_data';

class Barcodes {
  int? barcodeId;
  int? storeId;
  int? offerId;
 final String? barcodeValue;
  String? barcodeStatus;
  //int? branchId;
  int? userId;
  DateTime? barcodeDate;
final Uint8List? imageBytes;
  Barcodes({
    this.barcodeId,
    this.storeId,
    this.offerId,
    this.barcodeValue,
    this.barcodeStatus,
   // this.branchId,
    this.userId,
    this.barcodeDate,
    this.imageBytes,
  });

  factory Barcodes.fromJson(Map<String, dynamic> json) {
    return Barcodes(
      barcodeId: json['barcode_id'] as int? ?? 0,
      storeId: json['store_id'] as int? ?? 0,
      offerId: json['offer_id'] as int? ?? 0,
      barcodeValue: json['barcode_value'] as String? ?? '',
      barcodeStatus: json['barcode_status'] as String? ?? '',
      // branchId: json['branch_id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      barcodeDate: DateTime.parse(json['barcode_date']),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'barcode_id': barcodeId.toString(),
      'store_id': storeId.toString(),
      'offer_id': offerId.toString(),
      'barcode_value': barcodeValue,
      'barcode_status': barcodeStatus,
      //'branch_id': branchId.toString(),
      'user_id': userId.toString(),
      'barcode_date': barcodeDate!.toIso8601String(),
    };
  }
}