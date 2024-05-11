

// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/foundation.dart';
// import 'package:loyalty_app/model/category.dart';
// import 'package:loyalty_app/model/option_menu.dart';

// class Product {
//   late int id;
//   late String nameArabic;
//   late String nameEnglish;
//   late int categoryId;
 
//   late String image;
//   late double price;
  
//   late int quantity;
//   late String description;
//   late Catalog category;


  
//   //late double tax = 16.0;
//   int selectedQty = 0;
//   double additionalCost=0;
//   List<OptionalMenu> optionalMenuItems = [];
   
// Product.fromJson(Map<String, dynamic> json) {
//   id = json["product_id"] as int? ?? 0;
//   nameArabic = json["name_arabic"] ?? " ";
//   nameEnglish = json["name_english"] ?? " ";
//   categoryId = json["category_id"] as int? ?? 0;

//   image = json["image"] ?? "";
//   quantity = json["quantity"] as int? ?? 0;
//   description = json["product_descrption"] ?? "";
//   category = Catalog.fromJson(json["category"]);
// optionalMenuItems = (json['OptionalMenu'] as List<dynamic>?)
//                 ?.map((item) => OptionalMenu.fromJson(item))
//                 .toList() ?? [];
//   var priceValue = json["price"];
//   if (priceValue is num) {
//     price = priceValue.toDouble();
//   } else if (priceValue is String) {
   
//     try {
//       price = double.parse(priceValue);
//     } catch (e) {
     
//       if (kDebugMode) {
//         print("Error parsing price value: $e");
//       }
    
//       price = 0.0;
//     }
//   } else {
   
//     if (kDebugMode) {
//       print("Error: Unexpected price value type");
//     }
   
//     price = 0.0;
//   }
// }

  

//   // double get finalPrice {
//   //   return price * (1 + (tax / 100));
//   // }

//   double get subTotal {
//     return price * selectedQty;
//   }

//   // double get tax_amount {
//   //   return (price * (tax / 100)) * selectedQty;
//   // }

//   double get total {
//     double total = price * selectedQty; // Start with the product's price and quantity
//     // Add the prices of selected optional menu items
//     for (final optionalMenuItem in optionalMenuItems) {
//       total += optionalMenuItem.price ?? 0.0; // Add the price, if available
//     }
//     return total;
//   }
//   double get total2 => price * selectedQty;

//   Map<String, dynamic> toJson() => {
//         "product_id": id,
//         "id": categoryId,
      
//         "quantity": selectedQty,
//         "price":double.parse(price.toString()),
//         "total":double.parse(total.toString()) ,
//       };

     
  
 

// }


import 'package:flutter/foundation.dart';
import 'package:loyalty_app/model/category.dart';
import 'package:loyalty_app/model/option_menu.dart';


// class Product {
//   late int id;
//   late String nameArabic;
//   late String nameEnglish;
//   late int categoryId;
//   late String image;
//   late double price;
//   late int quantity;
//   late String description;
//   late Catalog category;
//   int selectedQty = 0;
//   double additionalCost = 0;
//   List<OptionalMenu> optionalMenuItems = [];

// factory Product.fromJson(Map<String, dynamic> json) {
//   return Product(
//     id: json["id"] as int? ?? 0,
//     nameArabic: json["name_ar"] as String? ?? "",
//     nameEnglish: json["name_eng"] as String? ?? "",
//     categoryId: json["category_id"] as int? ?? 0,
//     image: json["image"] as String? ?? "",
//     quantity: json["quantity"] as int? ?? 0,
//     description: json["product_descrption"] as String? ?? "",
//     category: json.containsKey("category") && json["category"] != null
//         ? Catalog.fromJson(json["category"] as Map<String, dynamic>)
//         : Catalog(categoryId: 0, nameArabic: "", nameEnglish: ""),
//     optionalMenuItems: json.containsKey("OptionalMenu") && json["OptionalMenu"] != null
//         ? (json['OptionalMenu'] as List<dynamic>)
//             .map((item) => OptionalMenu.fromJson(item as Map<String, dynamic>))
//             .toList()
//         : [],
//     price: _parsePrice(json["price"]),
//   );
// }

// static double _parsePrice(dynamic priceValue) {
//   if (priceValue is num) {
//     return priceValue.toDouble();
//   } else if (priceValue is String) {
//     try {
//       return double.parse(priceValue);
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error parsing price value: $e");
//       }
//     }
//   }
//   if (kDebugMode) {
//     print("Error: Unexpected price value type");
//   }
//   return 0.0;
// }


//   double get subTotal {
//     return price * selectedQty;
//   }

//   double get total {
//     double total = price * selectedQty;
//     for (final optionalMenuItem in optionalMenuItems) {
//       total += optionalMenuItem.price ?? 0.0;
//     }
//     return total;
//   }

//   double get total2 => price * selectedQty;

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "category_id": categoryId,
//         "quantity": selectedQty,
//         "price": double.parse(price.toString()),
//         "total": double.parse(total.toString()),
//       };
// }
class Product {
  late int id;
  late String nameArabic;
  late String nameEnglish;
  late int categoryId;
  late String image;
  late double price;
  late int quantity;
  late String description;
  late Catalog category;
  int selectedQty = 0;
  double additionalCost = 0;
  List<OptionalMenu> optionalMenuItems = [];

  // Constructor
  Product({
    required this.id,
    required this.nameArabic,
    required this.nameEnglish,
    required this.categoryId,
    required this.image,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    this.selectedQty = 0,
    this.additionalCost = 0,
    this.optionalMenuItems = const [],
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] as int? ?? 0,
      nameArabic: json["name_ar"] as String? ?? "",
      nameEnglish: json["name_eng"] as String? ?? "",
      categoryId: json["category_id"] as int? ?? 0,
      image: json["image"] as String? ?? "",
      quantity: json["quantity"] as int? ?? 0,
      description: json["product_descrption"] as String? ?? "",
      category: json.containsKey("category") && json["category"] != null
          ? Catalog.fromJson(json["category"] as Map<String, dynamic>)
          : Catalog(categoryId: 0, nameArabic: "", nameEnglish: ""),
      optionalMenuItems: json.containsKey("OptionalMenu") && json["OptionalMenu"] != null
          ? (json['OptionalMenu'] as List<dynamic>)
              .map((item) => OptionalMenu.fromJson(item as Map<String, dynamic>))
              .toList()
          : [],
      price: _parsePrice(json["price"]),
    );
  }

  static double _parsePrice(dynamic priceValue) {
    if (priceValue is num) {
      return priceValue.toDouble();
    } else if (priceValue is String) {
      try {
        return double.parse(priceValue);
      } catch (e) {
        if (kDebugMode) {
          print("Error parsing price value: $e");
        }
      }
    }
    if (kDebugMode) {
      print("Error: Unexpected price value type");
    }
    return 0.0;
  }

  double get subTotal {
    return price * selectedQty;
  }

  double get total {
    double total = price * selectedQty;
    for (final optionalMenuItem in optionalMenuItems) {
      total += optionalMenuItem.price ?? 0.0;
    }
    return total;
  }

  double get total2 => price * selectedQty;

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "quantity": selectedQty,
        "price": double.parse(price.toString()),
        "total": double.parse(total.toString()),
      };
}
