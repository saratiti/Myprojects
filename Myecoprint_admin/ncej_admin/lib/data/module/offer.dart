class Offer {

 int? id;
  final int companyId;
  final int storeId;
  final String offerNameArabic;
  final String offerNameEnglish;
  final String offerDescription;
  final int numberPoint;
  final double numberDiscount;
  final DateTime offerStartDate;
  final DateTime offerEndDate;
  final double offerDiscount;

  Offer({
   
   this.id,
    required this.companyId,
    required this.storeId,
    this.offerNameArabic = '',
    required this.offerNameEnglish,
    required this.offerDescription,
    required this.numberPoint,
    required this.numberDiscount,
    required this.offerStartDate,
    required this.offerEndDate,
    required this.offerDiscount,
  });

factory Offer.fromJson(Map<String, dynamic> json) {
  return Offer(
    id: json['offer_id'] as int? ?? 0,
    companyId: json['company_id'] as int? ?? 0,
    storeId: json['store_id'] as int? ?? 0,
    offerNameArabic: json['offer_name_arabic'] as String? ?? '',
    offerNameEnglish: json['offer_name_english'] as String? ?? '',
    offerDescription: json['offer_description'] as String? ?? '',
    numberPoint: json['number_point'] as int? ?? 0,
   
    offerStartDate: json['offer_start_date'] != null
        ? DateTime.parse(json['offer_start_date'])
        : DateTime.now(), 
    offerEndDate: json['offer_end_date'] != null
        ? DateTime.parse(json['offer_end_date'])
        : DateTime.now(), 

         numberDiscount: (json['number_discount'] is String)
        ? double.tryParse(json['number_discount'] ?? '0') ?? 0.0
        : (json['number_discount'] as num?)?.toDouble() ?? 0.0,



    offerDiscount: (json['offer_discount'] is String)
        ? double.tryParse(json['offer_discount'] ?? '0') ?? 0.0
        : (json['offer_discount'] as num?)?.toDouble() ?? 0.0,
  );
}



Map<String, dynamic> toJson() {
  return {
    "id": id.toString(),
    'company_id': companyId.toString(),
    'store_id':storeId.toString(),
    'offer_name_arabic': offerNameArabic,
    'offer_name_english': offerNameEnglish,
    'offer_description': offerDescription,
    'number_point': numberPoint.toString(),
    'number_discount': numberDiscount.toString(),
    'offer_start_date': offerStartDate.toIso8601String(),
    'offer_end_date': offerEndDate.toIso8601String(),
    'offer_discount': offerDiscount.toString(),
  };
}

}

