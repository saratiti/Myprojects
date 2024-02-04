import 'package:ncej_admin/data/module/offer.dart';

class Barcodes {
  int? barcodeId;
  int? storeId;
  int? offerId;
  String? barcodeValue;
  String? barcodeStatus;
  int? branchId;
  int? userId;
  DateTime? barcodeDate;
  Offer? offer; 

  Barcodes({
    this.barcodeId,
    this.storeId,
    this.offerId,
    this.barcodeValue,
    this.barcodeStatus,
    this.branchId,
    this.userId,
    this.barcodeDate,
    this.offer,
  });

  factory Barcodes.fromJson(Map<String, dynamic> json) {
    return Barcodes(
      barcodeId: json['barcode_id'] as int? ?? 0,
      storeId: json['store_id'] as int? ?? 0,
      offerId: json['offer_id'] as int? ?? 0,
      barcodeValue: json['barcode_value'] ?? '',
      barcodeStatus: json['barcode_status'] ?? '',
      branchId: json['branch_id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      barcodeDate: DateTime.parse(json['barcode_date']),
      offer: Offer.fromJson(json['offer']), // Assuming there is an 'offer' key in the JSON response
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barcode_id': barcodeId.toString(),
      'store_id': storeId.toString(),
      'offer_id': offerId.toString(),
      'barcode_value': barcodeValue,
      'barcode_status': barcodeStatus,
      'branch_id': branchId.toString(),
      'user_id': userId.toString(),
      'barcode_date': barcodeDate!.toIso8601String(),
      'offer': offer?.toJson(), // Convert the Offer object to JSON
    };
  }
}
