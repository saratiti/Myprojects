// ignore_for_file: prefer_null_aware_operators

class OptionalMenu {
  final int optionId;
  final String? nameArabic;
  final String? nameEnglish;
  final double? price;
   bool _isSelected = false;
 bool get isSelected => _isSelected;

  // Setter method for isSelected
  set isSelected(bool value) {
    _isSelected = value;
  }
  OptionalMenu({
    required this.optionId,
    this.nameArabic,
    this.nameEnglish,
    this.price,
  });

  factory OptionalMenu.fromJson(Map<String, dynamic> json) {
    return OptionalMenu(
      optionId: json['option_id'] != null ? json['option_id'] as int : 0,
      nameArabic: json['name_arabic'] as String?,
      nameEnglish: json['name_english'] as String?,
      price: json['price'] != null ? json['price'].toDouble() : null,
    );
  }

  List<Object?> get props => [
        optionId,
        nameArabic,
        nameEnglish,
        price,
      ];
}
