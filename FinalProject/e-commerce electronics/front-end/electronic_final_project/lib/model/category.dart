class Category {
  late int id;
  late String name;
  late String? image;

  Category(this.id, this.name, this.image);

factory Category.fromJson(Map<String, dynamic>? json) {
  if (json == null) {
    return Category(0, "", null);
  }
  return Category(
    int.parse(json["id"].toString()),
    json["name"] ?? "",
    json["image"] ?? null,
  );
}


}