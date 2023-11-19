// import 'package:electronic_final_project/controller/api_helper.dart';
// import 'package:electronic_final_project/model/brand.dart';
// import 'package:electronic_final_project/model/category.dart';
// import 'package:electronic_final_project/model/product.dart';
// import 'package:electronic_final_project/model/search.dart';

// class SearchController {
//   ApiHelper _apiHelper = ApiHelper();

//   Future<SearchData> performSearch(String searchTerm) async {
//     try {
//       var result = await _apiHelper.getRequest("/api/search/$searchTerm");
//       print('Response: $result');

//       if (result is Map<String, dynamic>) {
//         List<Product> products = [];
//         List<Brand> brands = [];
//         List<Category> categories = [];

//         if (result.containsKey('products')) {
//           var productData = result['products'] as List<dynamic>;
//           for (var item in productData) {
//             products.add(Product(
//               name: item['name'],
//               image: item['image'],
//               product: item['product'] != null ? Product.fromJson(item['product'] as Map<String, dynamic>) : null,
//             ));
//           }
//         }

//         if (result.containsKey('brands')) {
//           var brandData = result['brands'] as List<dynamic>;
//           for (var item in brandData) {
//             brands.add(Brand.fromJson(item as Map<String, dynamic>));
//           }
//         }

//         if (result.containsKey('categories')) {
//           var categoryData = result['categories'] as List<dynamic>;
//           for (var item in categoryData) {
//             categories.add(Category.fromJson(item as Map<String, dynamic>));
//           }
//         }

//         return SearchData(
//           products: products,
//           brands: brands,
//           categories: categories,
//         );
//       } else {
//         throw Exception('Invalid response format');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
