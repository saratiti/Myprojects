// ignore_for_file: library_private_types_in_public_api

import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

class TopRatedProducts extends StatefulWidget {


  const TopRatedProducts({Key? key,}) : super(key: key);

  @override
  _TopRatedProductsState createState() => _TopRatedProductsState();
}

class _TopRatedProductsState extends State<TopRatedProducts> {
  late Future<List<Product>> _productsFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  

  Future<void> _fetchProducts() async {
    try {
      List<Product> products = await ReviewController().getTopRatedProducts();
      setState(() {
        _productsFuture = Future.value(products);
      });
    } catch (ex) {
      if (kDebugMode) {
        print('Error fetching products: $ex');
      }
    }
  }

   @override
Widget build(BuildContext context) {
       mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
   child: FutureBuilder<List<Product>>(
    future: _productsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
        return const Center();
      } else {
        return SingleChildScrollView(
  child: GridView.builder(
    shrinkWrap: true, 
    physics: const NeverScrollableScrollPhysics(), 
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0, 
      childAspectRatio: 166.h / 190.v, 
    ),
    itemCount: snapshot.data!.length ,
    itemBuilder: (context, index) {
      return _buildProduct(context, snapshot.data![index]);
    },
  ),
);

      }
    },
   ) );
}
Widget _buildProduct(BuildContext context, Product product) {
  final localization = AppLocalizationController.to;
  final isEnglish = localization.locale.languageCode == 'en';

  return GestureDetector(
    onTap: () {
      _navigateToProductDetails(context, product.id);
    },
    child: Container(
      width: 166.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white, // Ensure the container has a background color
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0), // Adjust padding as needed
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 39.0),
                    Text(
                      isEnglish ? product.nameEnglish.localized : product.nameArabic.localized,
                      style: CustomTextStyles.titleSmallSenBluegray90001.copyWith(
                        color: appTheme.blueGray90001,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      product.description,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: appTheme.blueGray600,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Container(
                      width: 136.0,
                      margin: const EdgeInsets.only(left: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: product.price,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          CustomIconButton(
                            height: 31.0,
                            width: 32.0,
                            padding: const EdgeInsets.all(9.0),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgPlusWhiteA700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              height: 80, // Reduce the image size
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: product.image != null && product.image!.isNotEmpty
                    ? Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  // Widget _buildProduct(BuildContext context, Product product) {
  //                  final localization = AppLocalizationController.to;
  //   final isEnglish = localization.locale.languageCode == 'en';
  //   return  GestureDetector(
  //   onTap: () {
  //     _navigateToProductDetails(context,product.id);
  //   },
  //   child:
    
    
  //   Container(
  //     width: 166.0,
  //     margin: const EdgeInsets.symmetric(vertical: 8.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(24.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 1,
  //           blurRadius: 5,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Stack(
  //       alignment: Alignment.topLeft,
  //       children: [
  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(24.0),
  //               color: Colors.white,
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const SizedBox(height: 39.0),
  //                 Text(
  //                   isEnglish ? product.nameEnglish.localized : product.nameArabic.localized,
  //                   style: CustomTextStyles.titleSmallSenBluegray90001.copyWith(
  //                     color: appTheme.blueGray90001,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 5.0),
  //                 Text(
  //                   product.description,
  //                   style: theme.textTheme.bodyMedium!.copyWith(
  //                     color: appTheme.blueGray600,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 3.0),
  //                 Container(
  //                   width: 136.0,
  //                   margin: const EdgeInsets.only(left: 3.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       RatingBar.builder(
  //                         initialRating: product.price,
  //                         minRating: 1,
  //                         direction: Axis.horizontal,
  //                         allowHalfRating: true,
  //                         itemCount: 5,
  //                         itemSize: 20.0,
  //                         itemBuilder: (context, _) => const Icon(
  //                           Icons.star,
  //                           color: Colors.amber,
  //                         ),
  //                         onRatingUpdate: (rating) {},
  //                       ),
  //                       CustomIconButton(
  //                         height: 31.0,
  //                         width: 32.0,
  //                         padding: const EdgeInsets.all(9.0),
  //                         child: CustomImageView(
  //                           imagePath: ImageConstant.imgPlusWhiteA700,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         // CustomImageView(
  //         //   imagePath: product.image ?? "",
  //         //   height: 89.0,
  //         //   width: 60.0,
  //         //   alignment: Alignment.topLeft,
  //         //   margin: EdgeInsets.only(left: 48.0),
  //         // ),
  //       ],
  //     ),
  //    ) );
  // }
void _navigateToProductDetails(BuildContext context, int productId) {
  Navigator.of(context).pushNamed(
    AppRoutes.productDetailsScreen,
    arguments: {'productId': productId},
  );
}



}
