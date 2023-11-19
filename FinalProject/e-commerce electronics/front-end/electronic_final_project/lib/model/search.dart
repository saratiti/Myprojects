import 'package:electronic_final_project/model/brand.dart';
import 'package:electronic_final_project/model/category.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/search/search.dart';

class SearchData {
  List<Product> products;
  List<Brand> brands;
  List<Category> categories;

  SearchData({required this.products, required this.brands, required this.categories});
}