import 'package:electronic_final_project/controller/api_helper.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';

import 'package:electronic_final_project/model/brand.dart';
import 'package:electronic_final_project/model/category.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/model/search.dart';
import 'package:electronic_final_project/product/product_card_item_widget.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:flutter/material.dart';

class SearchController {
  ApiHelper _apiHelper = ApiHelper();

  Future<SearchData> performSearch(String searchTerm) async {
    try {
      var result = await _apiHelper.getRequest("/api/search/$searchTerm");
      print('Response: $result');

      if (result is Map<String, dynamic>) {
        List<Product> products = [];
        List<Brand> brands = [];
        List<Category> categories = [];

        if (result.containsKey('products')) {
          var productData = result['products'] as List<dynamic>;
          for (var item in productData) {
            products.add(Product.fromJson(item as Map<String, dynamic>));
          }
        }

        if (result.containsKey('brands')) {
          var brandData = result['brands'] as List<dynamic>;
          for (var item in brandData) {
            brands.add(Brand.fromJson(item as Map<String, dynamic>));
          }
        }

        if (result.containsKey('categories')) {
          var categoryData = result['categories'] as List<dynamic>;
          for (var item in categoryData) {
            categories.add(Category.fromJson(item as Map<String, dynamic>));
          }
        }

        return SearchData(
          products: products,
          brands: brands,
          categories: categories,
        );
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTerm = '';
  final SearchController _searchController = SearchController();
  late Future<SearchData> _searchFuture;
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchFuture = Future.value(SearchData(products: [], brands: [], categories: []));
  }

  void search(String searchTerm) {
    setState(() {
      _searchFuture = _searchController.performSearch(searchTerm);
    });
  }

  void clearSearch() {
    setState(() {
      _searchTextController.clear();
      searchTerm = '';
      _searchFuture = Future.value(SearchData(products: [], brands: [], categories: []));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 244, 244),
        ), 
        child: Column(
          children: [
            SizedBox(height: 40.0),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 222, 220, 220),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(

                children: [
                         AppbarImage(
                                  height: getSize(24),
                                  width: getSize(24),
                                  svgPath: ImageConstant.imgArrowleftBlueGray900,
                                  margin: getMargin(top: 15),
                                  onTap: () {
                                    onTapArrowleft(context);
                                  },
                                ),
                  Expanded(
                    child: TextField(
                      controller: _searchTextController,
                      onChanged: (value) {
                        searchTerm = value.trim();
                        if (searchTerm.isNotEmpty) {
                          search(searchTerm);
                        }
                      },
                      onSubmitted: (_) => search(searchTerm),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: clearSearch,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                child: FutureBuilder<SearchData>(
                  future: _searchFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      List<Product> products = snapshot.data!.products;
                      List<Brand> brands = snapshot.data!.brands;
                      List<Category> categories = snapshot.data!.categories;

                      List<Product> searchResults = products;

                      if (searchResults.isEmpty) {
                        return Center(child: Text('No results found'));
                      }

                      return ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Product selectedProduct = searchResults[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(product: selectedProduct),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Image.network(
                                    searchResults[index].image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Text(
                                      searchResults[index].name,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        searchResults.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void onTapArrowleft(BuildContext context) {
 Navigator.of(context).pop();

  }


}

  
