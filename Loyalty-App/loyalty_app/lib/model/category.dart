class Category {
  late int id;
  late String nameArabic;
  late String nameEnglish;
  late String? logo;

  Category(this.id, this.nameArabic,this.nameEnglish, this.logo);

factory Category.fromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return Category(0, "","", null);
  }
  return Category(
    int.parse(json["category_id"].toString()),
    json["name_arabic"] ?? "",
    json["name_english"] ?? "",
    json["logo"] ?? null,
  );
}


}