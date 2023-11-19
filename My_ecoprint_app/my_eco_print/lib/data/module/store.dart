
import 'package:my_eco_print/data/module/offer.dart';
import 'package:my_eco_print/data/module/points_redeemed.dart';

class Store {
 int? id;
  String nameArabic;
  String nameEnglish;
  int companyId;
  int typeId;
  String? image;
List<Offer>? offers;
List<PointRedemption>?pointsRedeemeds;


  Store({
     this.id,
    required this.nameArabic,
    required this.nameEnglish,
    required this.companyId,
    required this.typeId,
     this.image,
     this .offers,
     this.pointsRedeemeds,

 
  });

factory Store.fromJson(Map<String, dynamic> json) {
  return Store(
    id: json['store_id'] as int? ?? 0,
    nameArabic: json['name_arabic'] as String? ?? '',
    nameEnglish: json['name_english'] as String? ?? '',
    companyId: json['company_id'] as int? ?? 0,
    typeId: json['type_id'] as int? ?? 0,
    image: json['image'] as String? ?? '',
   offers: (json['offers'] as List<dynamic>?)
          ?.map((offerJson) => Offer.fromJson(offerJson))
          .toList(),
      pointsRedeemeds: (json['pointsRedeemeds'] as List<dynamic>?)
          ?.map((pointsRedeemedJson) => PointRedemption.fromJson(pointsRedeemedJson))
          .toList(),
  
  );
  
}

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      'name_arabic': nameArabic.toString(),
      'name_english': nameEnglish.toString(),
      'company_id': companyId.toString(),
      'type_id': typeId.toString(),
      'image': image.toString(),
     
    };
  }
}

