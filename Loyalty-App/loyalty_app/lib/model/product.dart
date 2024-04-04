

import 'package:loyalty_app/model/category.dart';

class Product {
  late int id;
  late String nameArabic;
  late String nameEnglish;
  late int categoryId;
 
  late String image;
  late double price;
  
  late int quantity;
  late String description;
  late Category category;


  
  late double tax = 16.0;
  int selectedQty = 0;
   
Product.fromJson(Map<String, dynamic> json) {
  id = json["product_id"] as int? ?? 0;
  nameArabic = json["name_arabic"] ?? " ";
  nameEnglish = json["name_english"] ?? " ";
  categoryId = json["category_id"] as int? ?? 0;

  image = json["image"] ?? "";
  quantity = json["quantity"] as int? ?? 0;
  description = json["product_descrption"] ?? "";
  category = Category.fromJson(json["category"]);

  var priceValue = json["price"];
  if (priceValue is num) {
    price = priceValue.toDouble();
  } else if (priceValue is String) {
    // Handle parsing of string to double
    try {
      price = double.parse(priceValue);
    } catch (e) {
      // Handle error if parsing fails
      print("Error parsing price value: $e");
      // Set price to a default value or handle error case as needed
      price = 0.0;
    }
  } else {
    // Handle other cases where price value is not a num or string
    print("Error: Unexpected price value type");
    // Set price to a default value or handle error case as needed
    price = 0.0;
  }
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
        "category_id": categoryId,
      
        "quantity": selectedQty,
        "price":double.parse(price.toString()),
        "total":double.parse(total.toString()) ,
      };

     
  
 

}


