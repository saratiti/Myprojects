class ReasonBarcode {
  int reasonBarcodeId;
  String reasonArabic;
  String? reasonEnglish;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ReasonBarcode({
    required this.reasonBarcodeId,
    required this.reasonArabic,
    this.reasonEnglish,
  
  });

  factory ReasonBarcode.fromJson(Map<String, dynamic> json) {
    return ReasonBarcode(
      reasonBarcodeId: json['reasonBarcode_id']as int? ??0,
      reasonArabic: json['reason_arabic']as String? ?? '',
      reasonEnglish: json['reason_english']as String? ?? '',
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reasonBarcode_id': reasonBarcodeId,
      'reason_arabic': reasonArabic,
      'reason_english': reasonEnglish,
   
    };
  }
}
