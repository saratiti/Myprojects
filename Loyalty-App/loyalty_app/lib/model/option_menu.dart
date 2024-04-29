// ignore_for_file: prefer_null_aware_operators

class OptionalMenu {
  final int optionId;
  final int productId; // Added productId field
  final String? nameArabic;
  final String? nameEnglish;
  final double? price;
  bool isSelected = false;

  OptionalMenu({
    required this.optionId,
    required this.productId, // Added productId to the constructor
    this.nameArabic,
    this.nameEnglish,
    this.price,
  });

  factory OptionalMenu.fromJson(Map<String, dynamic> json) {
    return OptionalMenu(
      optionId: json['option_id'] != null ? json['option_id'] as int : 0,
      productId: json['product_id'] != null ? json['product_id'] as int : 0, // Added product_id
      nameArabic: json['name_arabic'] as String?,
      nameEnglish: json['name_english'] as String?,
      price: json['price'] != null ? json['price'].toDouble() : null,
    );
  }

  List<Object?> get props => [
        optionId,
        productId,
        nameArabic,
        nameEnglish,
        price,
      ];
}
