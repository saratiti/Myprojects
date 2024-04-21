import 'dart:typed_data';

class Catalog {
 final  int id;
 final   String nameArabic;
 final   String nameEnglish;
final   String? image;
  List<Uint8List>? imageBytesList; 

  Catalog(
    
    { required this.id,required this.nameArabic,required this.nameEnglish, this.image,this.imageBytesList, });
   

factory Catalog.fromJson(Map<String, dynamic>? json) {
 
  return Catalog(
    id:json!['id']as int? ?? 0,
   nameEnglish: json["name_arabic"] ?? "",
   nameArabic:  json["name_english"] ?? "",
   image: json["image"], 
    
  );
}


}