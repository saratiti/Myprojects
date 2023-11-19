import 'package:electronic_final_project/controller/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:electronic_final_project/controller/review.dart';
import 'package:electronic_final_project/controller/product.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/model/review.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final availableHeight = screenSize.height - kToolbarHeight - 50;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: FutureBuilder<List<Product>>(
        future: ProductController().getTopRatedProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Product> products = snapshot.data!;
            return Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: availableHeight,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2.0,
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            product.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10.0),
                                            Text(
                                              '\$${product.price.toStringAsFixed(2)}',
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle
                                                  .txtSFUIDisplaySemibold14,
                                            ),
                                            SizedBox(height: 3.0),
                                            Text(
                                              product.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle
                                                  .txtSFUIDisplayMedium14,
                                            ),
                                            SizedBox(height: 3.0),
                                            Text(
                                              product.brand.brand_name,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle
                                                  .txtSFUIDisplayRegular14Gray600,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.shopping_cart_rounded),
                                      color: Colors.orange,
                                      onPressed: () {
                                        final cartProvider =
                                            Provider.of<ProductProvider>(
                                                context,
                                                listen: false);
                                        cartProvider.addToCart(product);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
