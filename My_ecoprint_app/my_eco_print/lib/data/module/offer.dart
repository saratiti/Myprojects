import 'package:my_eco_print/data/module/company.dart';
import 'package:my_eco_print/data/module/store.dart';

class Offer {
  int? id;
  final int companyId;
  final int branchId;
  final int storeId;
  final String offerNameArabic;
  final String offerNameEnglish;
  final String offerDescription;
  final int numberPoint;
  double numberDiscount;
  final DateTime offerStartDate;
  final DateTime offerEndDate;
  final double offerDiscount;
  Store? store;
  Company? company;

  Offer({
    this.id,
    required this.companyId,
    required this.branchId,
    this.offerNameArabic = '',
    required this.offerNameEnglish,
    required this.offerDescription,
    required this.numberPoint,
    required this.numberDiscount,
    required this.offerStartDate,
    required this.offerEndDate,
    required this.offerDiscount,
    required this.storeId,
    this.store,
    this.company,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['offer_id'] != null ? int.tryParse(json['offer_id'].toString()) ?? 0 : 0,
      companyId: json['company_id'] != null ? int.tryParse(json['company_id'].toString()) ?? 0 : 0,
      storeId: json['store_id'] != null ? int.tryParse(json['store_id'].toString()) ?? 0 : 0,
      branchId: json['branch_id'] != null ? int.tryParse(json['branch_id'].toString()) ?? 0 : 0,
      offerNameArabic: json['offer_name_arabic'] ?? '',
      offerNameEnglish: json['offer_name_english'] ?? '',
      offerDescription: json['offer_description'] ?? '',
      numberPoint: json['number_point'] != null ? int.tryParse(json['number_point'].toString()) ?? 0 : 0,
      numberDiscount: (json['number_discount'] is String)
          ? double.tryParse(json['number_discount'] ?? '0') ?? 0.0
          : (json['number_discount'] as num?)?.toDouble() ?? 0.0,
      offerStartDate: json['offer_start_date'] != null ? DateTime.parse(json['offer_start_date']) : DateTime.now(),
      offerEndDate: json['offer_end_date'] != null ? DateTime.parse(json['offer_end_date']) : DateTime.now(),
      offerDiscount: json['offer_discount'] != null ? double.tryParse(json['offer_discount'].toString()) ?? 0.0 : 0.0,
     store: json['stores'] != null ? Store.fromJson(json['stores']) : null,
      company: json['company'] != null ? Company.fromJson(json['company'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      'company_id': companyId.toString(),
      'store_id': storeId.toString(),
      'branch_id': branchId.toString(),
      'offer_name_arabic': offerNameArabic,
      'offer_name_english': offerNameEnglish,
      'offer_description': offerDescription,
      'number_point': numberPoint.toString(),
      'number_discount': numberDiscount.toString(),
      'offer_start_date': offerStartDate.toIso8601String(),
      'offer_end_date': offerEndDate.toIso8601String(),
      'offer_discount': offerDiscount.toString(),
      "store": store?.toJson(),
      "company": company?.toJson(),
    };
  }
}
