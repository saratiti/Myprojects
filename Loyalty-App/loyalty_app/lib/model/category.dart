import 'dart:typed_data';

class Catalog {
  final int categoryId;
  final String nameArabic;
  final String nameEnglish;
  final String? logo; 
  List<Uint8List>? imageBytesList;

  Catalog({
    required this.categoryId,
    required this.nameArabic,
    required this.nameEnglish,
    this.logo, 
    this.imageBytesList,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) {
    return Catalog(
      categoryId: json["id"] as int? ?? 0,
      nameEnglish: json["name_english"] as String? ?? '',
      nameArabic: json["name_arabic"] as String? ?? '',
      logo: json["image"] as String?, 
    );
  }
}
