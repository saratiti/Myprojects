
import 'package:electronic_final_project/model/brand.dart';
import 'package:electronic_final_project/model/category.dart';
import 'package:electronic_final_project/model/color.dart';
import 'package:electronic_final_project/model/size.dart';


class Product {
  late int id;
  late String name;
  late int categoryId;
  late int brandId;
  late String image;
  late double price;
  late bool active;
  late int quantity;
  late String description;
  late Category category;
  late Brand brand;
  List<ColorProduct> colors = [];

  List<SizeProduct> sizes = [];
  
  late double tax = 16.0;
  int selectedQty = 0;
   
Product.fromJson(Map<String, dynamic> json) {
  id = json["id"] as int? ?? 0;
  name = json["name"] ?? " ";
  categoryId = json["category_id"] as int? ?? 0;
  brandId = json["brand_id"] as int? ?? 0;
  image = json["image"] ?? "";
  price = (json["price"] as num?)?.toDouble() ?? 0.0;
  quantity = json["quantity"] as int? ?? 0;
  description = json["description"] ?? "";
  category = Category.fromJson(json["category"]);
  brand = Brand.fromJson(json["brand"]);
  final colorJson = json['colors'] as List<dynamic>?; 
  colors = colorJson != null
      ? colorJson.map((color) => ColorProduct.fromJson(color)).toList()
      : [];
}

  

  double get finalPrice {
    return price * (1 + (tax / 100));
  }

  double get subTotal {
    return price * selectedQty;
  }

  double get tax_amount {
    return (price * (tax / 100)) * selectedQty;
  }

  double get total {
    return (price * (1 + (tax / 100))) * selectedQty;
  }

  double get total2 => price * selectedQty;

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": categoryId,
        "brand_id": brandId,
        "quantity": selectedQty,
        "price":double.parse(price.toString()),
        "total":double.parse(total.toString()) ,
      };

     
  
 

}


