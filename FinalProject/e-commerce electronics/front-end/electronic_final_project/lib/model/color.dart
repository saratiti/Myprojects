class ColorProduct {
  late String colors;
  late int productId;

  ColorProduct({
    required this.colors,
    required this.productId,
  });

  factory ColorProduct.fromJson(Map<String, dynamic> json) {
    return ColorProduct(
      colors: json['color'] as String? ?? '',
      productId: json['product_id'] as int? ?? 0,
    );
  }
}


