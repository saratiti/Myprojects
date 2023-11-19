class Type {
  int typeId;
  String typeArabic;
  String typeEnglish;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Type({
    required this.typeId,
    required this.typeArabic,
    required this.typeEnglish,
  
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      typeId: json['type_id']as int? ??0,
      typeArabic: json['type_arabic']as String? ?? '',
      typeEnglish: json['type_english']as String? ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_id': typeId,
      'type_arabic': typeArabic,
      'type_english': typeEnglish,
     
    };
  }
}
