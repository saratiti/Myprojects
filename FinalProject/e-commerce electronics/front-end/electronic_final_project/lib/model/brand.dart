
class Brand {
  late int id;
  late String brand_name;
  late String image;

  Brand(this.id, this.brand_name,this.image);

  factory Brand.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Brand(0, "","");
    }
    return Brand(
      int.parse(json["id"].toString()),
      json["brand_name"] ?? "",
      json["image"]??""
    );
  }
}
