
class Store {
 int? id;
  String nameArabic;
  String nameEnglish;
  int companyId;
  int typeId;
  String? image;


  Store({
     this.id,
    required this.nameArabic,
    required this.nameEnglish,
    required this.companyId,
    required this.typeId,
     this.image,
 
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
     id: json['store_id'] as int? ?? 0,
      nameArabic: json['name_arabic']as String? ?? '',
      nameEnglish: json['name_english']as String? ?? '',
      companyId: json['company_id']as int? ??0,
      typeId: json['type_id']as int? ??0,
      image: json['image']as String? ?? '',

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

