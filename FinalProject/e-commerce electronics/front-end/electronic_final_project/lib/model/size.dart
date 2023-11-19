class SizeProduct {
  late String sizes;
  late int productId;

  SizeProduct({
    required this.sizes,
    required this.productId,
  });

  factory SizeProduct.fromJson(Map<String, dynamic> json) {
    return SizeProduct(
      sizes: json['size'] as String? ?? '',
      productId: json['product_id'] as int? ?? 0,
    
    );
  }
}