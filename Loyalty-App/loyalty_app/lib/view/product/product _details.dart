

// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:loyalty_app/view/product/widgets/product_details_page1.dart';


class ProductDetailsPage extends StatefulWidget {


  const ProductDetailsPage({Key? key,}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
    late Future<Map<String, dynamic>> _productDetailsFuture;
    
  late int productId;
String ?selectedSize;
int quantity = 0; 
 late Set<OptionalMenu> selectedItems;
 late double totalOptionalMenuPrice;
   String comment = '';
  double starRating = 0.0;
  bool isLoading = false; 
bool showLoadingIndicator = false;
late FocusNode _commentFocusNode;

  @override
  void initState() {
    super.initState();
    selectedItems = {};
    totalOptionalMenuPrice = 0.0;
    _commentFocusNode = FocusNode();
    showLoadingIndicator = false;
    productId = 0;
    _productDetailsFuture = _fetchAndSetProductDetails(productId);
  }






@override
void dispose() {
  _commentFocusNode.dispose();
  super.dispose();
}


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic> && arguments.containsKey('productId')) {
      final dynamic productIdValue = arguments['productId'];
      if (productIdValue is int && productIdValue != 0) {
        productId = productIdValue;
        _fetchAndSetProductDetails(productId);
      } else {
        if (kDebugMode) {
          print('Invalid or zero product ID: $productIdValue');
        }
      }
    } else {
      if (kDebugMode) {
        print('Product ID not found in arguments: $arguments');
      }
    }
  }

Future<Map<String, dynamic>> _fetchAndSetProductDetails(int productId) async {
  try {
    final productDetails = await ProductController().getProductWithOptionalMenu(productId);
    setState(() {
      _productDetailsFuture = Future.value(productDetails);
    });
    if (kDebugMode) {
      print('Response Body: $productDetails');
    }
    return productDetails;
  } catch (error) {
    setState(() {
      _productDetailsFuture = Future.error(error);
    });
    if (kDebugMode) {
      print('Error fetching product details: $error');
    }
    rethrow; 
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
    child: SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _productDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appTheme.deepOrange800),
                  ),
                );
              } else if (snapshot.hasError) {
                return Container(); // Or you can return a loading indicator widget here
              } else {
                final dynamic productData = snapshot.data!['product'];
                final dynamic optionalMenuItemsData = snapshot.data!['optionalMenuItems'];

                if (productData != null && productData is Product) {
                  final Product product = productData;
                  List<OptionalMenu> optionalMenuItems = [];

                  if (optionalMenuItemsData != null && optionalMenuItemsData is List<OptionalMenu>) {
                    optionalMenuItems = optionalMenuItemsData;
                  }

                  // Pass the selected quantity variable here
                  const int selectedQuantity = 1; // Replace 1 with your actual selected quantity value
                 return ProductDetailsPage1(
  product: product,
  optionalMenuItems: optionalMenuItems,
  selectedQuantity: selectedQuantity,
);

                } else {
                  return const Center(
                    child: Text('Product not found'), 
                  );
                }
              }
            },
          ),
        ),
      ),
    ),
  );
}


// Widget _buildProductDetails(
//   Product product, 
//   List<OptionalMenu> optionalMenuItems, 
//   int selectedQuantity,
// ) {
//   final localization = AppLocalizationController.to;
//   final isEnglish = localization.locale.languageCode == 'en';

  
//   return Consumer<ProductProvider>(
//     builder: (context, productProvider, _) {
//       return 
  
  
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       _buildMask(context),
//       Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               isEnglish ? product.nameEnglish.localized : product.nameArabic.localized,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               '\$${product.price}',
//               style: TextStyle(fontSize: 20, color: appTheme.deepOrange800),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: EdgeInsets.only(left: 19.h),
//               child: Text(
//                 "Description",
//                 style: CustomTextStyles.titleSmallGray80001,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               width: 313.h,
//               margin: EdgeInsets.only(left: 19.h),
//               child: ReadMoreText(
//                 product.description,
//                 trimLines: 3,
//                 trimMode: TrimMode.Line,
//                 moreStyle: CustomTextStyles.bodySmallInterGray80001.copyWith(
//                   height: 1.83,
//                 ),
//                 lessStyle: CustomTextStyles.bodySmallInterGray80001.copyWith(
//                   height: 1.83,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             if (optionalMenuItems.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 19.h),
//                     child: Text(
//                       "Additional Options",
//                       style: CustomTextStyles.titleSmallGray80001,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: optionalMenuItems.map((menu) {
//                       bool isSelected = selectedItems.contains(menu);
//                       return Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Checkbox(
//                             value: isSelected,
//                             activeColor: isSelected
//                               ? appTheme.deepOrange800
//                               : appTheme.gray100,
//                             onChanged: (newValue) {
//                               if (newValue != null) {
//                                 setState(() {
//                                   if (newValue) {
//                                     selectedItems.add(menu);
//                                     totalOptionalMenuPrice += menu.price!;
//                                   } else {
//                                     selectedItems.remove(menu);
//                                     totalOptionalMenuPrice -= menu.price!;
//                                   }
//                                   menu.isSelected = newValue;
//                                 });
//                               }
//                             },
//                           ),
//                           Text(
//                             ' ${menu.nameEnglish ?? menu.nameArabic}',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: isSelected
//                                 ? appTheme.deepOrange800
//                                 : appTheme.black900,
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             '\$${menu.price}',
//                             style: const TextStyle(fontSize: 14, color: Colors.grey),
//                           ),
//                           const SizedBox(height: 5),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             const SizedBox(height: 20),
//             const Row(
//               children: [
//                 Text(
//                   'Choose Size',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(width: 50),
//                 Text(
//                   "Quantity",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 _buildSelectSize(),
//                 const SizedBox(width: 10),
//                 _buildQuantitySelector(context, product),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const SizedBox(height: 20),
//             Text(
//               'Product Reviews',
//               style: CustomTextStyles.titleSmallGray80001,
//             ),
//             const SizedBox(height: 10),
//             FutureBuilder<List<Review>>(
//               future: ReviewController().getProductReviews(productId),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 } else if (snapshot.hasData) {
//                   final reviews = snapshot.data!;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: reviews.length,
//                     itemBuilder: (context, index) {
//                       return ProductReview(review: reviews[index]);
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: Text('No reviews available.'),
//                   );
//                 }
//               },
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Leave a Review',
//               style: CustomTextStyles.bodySmallInterGray80001,
//             ),
//             const SizedBox(height: 10),
//             RatingBar.builder(
//               initialRating: starRating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemSize: 30,
//               itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//               itemBuilder: (context, _) => const Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (rating) {
//                 setState(() {
//                   starRating = rating;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 border: Border.all(
//                   width: 1,
//                   color: const Color.fromARGB(255, 211, 210, 210),
//                 ),
//                 color: const Color.fromARGB(255, 204, 203, 203),
//               ),
//               child: TextFormField(
//                 focusNode: _commentFocusNode,
//                 maxLines: 1,
//                 controller: _commentController, 
//                 decoration: InputDecoration(
//                   labelText: 'Comment',
//                   labelStyle: const TextStyle(color: Colors.grey),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 16,
//                   ),
//                   suffixIcon: showLoadingIndicator
//                     ? CircularProgressIndicator()
//                     : IconButton(
//                         onPressed: () {
//                           _submitReview(context);
//                         },
//                         icon: Icon(Icons.send, color: Colors.white),
//                       ),
//                 ),
//                 style: const TextStyle(color: Colors.grey),
//                 cursorColor: appTheme.deepOrange800,
//                 onTap: () {
//                   if (EasyLoading.isShow) {
//                     EasyLoading.dismiss();
//                   }
//                 },
//                 onChanged: (value) {
//                   comment = value;
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(height: 25.v),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 19.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Price",
//                         style: CustomTextStyles.bodyMediumInterGray60001,
//                       ),
//                       SizedBox(height: 3.v),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "\$${(product.price + totalOptionalMenuPrice) * productProvider.getCartItemQuantity(product)}",
//                             style: CustomTextStyles.headlineSmallInterGray80001,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   CustomElevatedButton(
//                     onPressed: () {
//                       _addToCart(context, product, optionalMenuItems);
//                           showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return SummaryInvoiceWidget();
//                       },
//                     );

//                     },
//                     height: 50.v,
//                     width: 190.h,
//                     text: "Buy Now",
//                     margin: EdgeInsets.only(bottom: 4.v),
//                     buttonStyle: CustomButtonStyles.fillPrimary,
//                     buttonTextStyle: CustomTextStyles.titleMediumSFProText,
//                  ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
// );});
// }


  
  
void navigateToCartScreen(BuildContext context) {




}








}


