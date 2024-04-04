


import 'package:flutter/material.dart';
import 'package:loyalty_app/controller/product.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/model/option_menu.dart';
import 'package:loyalty_app/model/product.dart';
import 'package:loyalty_app/view/product/widgets/frameseventyone_item_widget.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_icon_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';
import 'package:readmore/readmore.dart';

// class ProductDetailsPage extends StatefulWidget {
//   const ProductDetailsPage({Key? key}) : super(key: key);

//   @override
//   _ProductDetailsPageState createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {

//   late Future<Map<String, dynamic>> _productDetailsFuture;
//   late int productId;

//   @override
//   void initState() {
//     super.initState();
//     _productDetailsFuture = Future.value({});
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final arguments = ModalRoute.of(context)?.settings.arguments;
//     if (arguments != null && arguments is Map<String, dynamic> && arguments.containsKey('productId')) {
//       final dynamic productIdValue = arguments['productId'];
//       if (productIdValue is int && productIdValue != 0) {
//         productId = productIdValue;
//         _fetchAndSetProductDetails(productId);
//       } else {
//         print('Invalid or zero product ID: $productIdValue');
//       }
//     } else {
//       print('Product ID not found in arguments: $arguments');
//     }
//   }

// void _fetchAndSetProductDetails(int productId) async {
//   try {
//     final productDetails = await ProductController().getProductWithOptionalMenu(productId);
//     setState(() {
//       _productDetailsFuture = Future.value(productDetails);
//     });
//     print('Response Body: $productDetails');
//   } catch (error) {
//     // Handle error while fetching product details
//     print('Error fetching product details: $error');
//   }
// }
//  bool nutsSelected = false;
//   bool synthsSelected = false;
//   bool honeySelected = false;
//   String ?selectedSize;
//     @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             width: double.maxFinite,
//             padding: EdgeInsets.symmetric(vertical: 11.v),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildMask(context),
//                 SizedBox(height: 43.v),
//                 Padding(
//                   padding: EdgeInsets.only(left: 19.h),
//                   child: Text(
//                     "Description",
//                     style: CustomTextStyles.titleSmallGray80001,
//                   ),
//                 ),
//                 SizedBox(height: 16.v),
//                 Container(
//                   width: 313.h,
//                   margin: EdgeInsets.only(left: 19.h),
//                   child: ReadMoreText(
//                     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel tincidunt et ullamcorper eu, vivamus semper commodo............Read More",
//                     trimLines: 3,
//                     trimMode: TrimMode.Line,
//                     moreStyle: CustomTextStyles.bodySmallInterGray80001.copyWith(
//                       height: 1.83,
//                     ),
//                     lessStyle: CustomTextStyles.bodySmallInterGray80001.copyWith(
//                       height: 1.83,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.v),
//                 Padding(
//                   padding: EdgeInsets.only(left: 19.h),
//                   child: Text(
//                     "Choice of Chocolate",
//                     style: CustomTextStyles.titleSmallGray80001,
//                   ),
//                 ),
//                 SizedBox(height: 15.v),
//                 _buildFrameSeventyOne(context),
//                 SizedBox(height: 23.v),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 19.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Size",
//                         style: CustomTextStyles.titleSmallGray80001,
//                       ),
//                       Text(
//                         "Quantity",
//                         style: CustomTextStyles.titleSmallGray80001,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 13.v),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 19.h),
//                   child: Row(
//                     children: [
//                     _buildSelectSize(),
//                       Spacer(),
//                       CustomIconButton(
//                         height: 35.adaptSize,
//                         width: 35.adaptSize,
//                         padding: EdgeInsets.all(5.h),
//                         child: CustomImageView(
//                           imagePath: ImageConstant.imgMegaphoneWhiteA700,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 26.h,
//                           top: 9.v,
//                           bottom: 8.v,
//                         ),
//                         child: Text(
//                           "1",
//                           style: CustomTextStyles.titleSmallBluegray90002,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 26.h),
//                         child: CustomIconButton(
//                           height: 35.adaptSize,
//                           width: 35.adaptSize,
//                           padding: EdgeInsets.all(5.h),
//                           child: CustomImageView(
//                             imagePath: ImageConstant.imgPlus,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
               
//                SizedBox(height: 25),
//                Padding(
//                   padding: EdgeInsets.only(left: 19.h),
//                   child: Text(
//                     "Addtional other",
//                     style: CustomTextStyles.titleSmallGray80001,
//                   ),
//                 ),
//          Padding(
//   padding: EdgeInsets.symmetric(horizontal: 19),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       _buildChoiceOption("Nuts", nutsSelected, "Additional  for nuts", "\$2.50", (value) {
//         setState(() {
//           nutsSelected = value!;
//         });
//       }),
//       SizedBox(height: 20),
//       _buildChoiceOption("Synths", synthsSelected, "Additional  for synths", "\$3.00", (value) {
//         setState(() {
//           synthsSelected = value!;
//         });
//       }),
//       SizedBox(height: 20),
//       _buildChoiceOption("Honey", honeySelected, "Additional  for honey", "\$2.00", (value) {
//         setState(() {
//           honeySelected = value!;
//         });
//       }),
//     ],
//   ),
// ),


//                 SizedBox(height: 25.v),

//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 19.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Price",
//                             style: CustomTextStyles.bodyMediumInterGray60001,
//                           ),
//                           SizedBox(height: 3.v),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "",
//                                 style: CustomTextStyles.headlineSmallInterPrimary,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 5.h),
//                                 child: Text(
//                                   "4.20",
//                                   style: CustomTextStyles.headlineSmallInterGray80001,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       CustomElevatedButton(
//                         height: 50.v,
//                         width: 190.h,
//                         text: "Buy Now",
//                         margin: EdgeInsets.only(
//                           bottom: 4.v,
//                         ),
//                         buttonStyle: CustomButtonStyles.fillPrimary,
//                         buttonTextStyle: CustomTextStyles.titleMediumSFProText,
//                       ),
//                     ],
//                   ),
//                 ),
                
              
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

 
//   Widget _buildMask(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: SizedBox(
//         height: 390.v,
//         width: 388.h,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
        
//             Align(
//               alignment: Alignment.center,
//               child: SizedBox(
//                 height: 390.v,
//                 width: 388.h,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     Align(
//                       alignment: Alignment.center,
//                       child: SizedBox(
//                         height: 383.v,
//                         width: 388.h,
//                         child: Stack(
//                           alignment: Alignment.topCenter,
//                           children: [
//                             CustomImageView(
//                               imagePath: ImageConstant.imgImg383x388,
//                               height: 383.v,
//                               width: 388.h,
//                               radius: BorderRadius.circular(
//                                 40.h,
//                               ),
//                               alignment: Alignment.center,
//                             ),
//                             Align(
//                               alignment: Alignment.topCenter,
//                               child: Container(
//                                 margin: EdgeInsets.fromLTRB(
//                                     25.h, 18.v, 34.h, 329.v),
//                                 decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadiusStyle.roundedBorder15,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                 GestureDetector(
//   onTap: () {
//     Navigator.of(context).pop();
//   },
//   child: CustomIconButton(
//     height: 35.adaptSize,
//     width: 35.adaptSize,
//     padding: EdgeInsets.all(6.h),
//     child: CustomImageView(
//       imagePath: ImageConstant.imgArrowLeft,
//     ),
//   ),
// ),

//                                     CustomIconButton(
//                                       height: 35.adaptSize,
//                                       width: 35.adaptSize,
//                                       padding: EdgeInsets.all(6.h),
//                                       decoration:
//                                           IconButtonStyleHelper.fillWhiteATL17,
//                                       child: CustomImageView(
//                                         imagePath: ImageConstant.imgHeart,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         margin: EdgeInsets.only(top: 269.v),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 27.h,
//                           vertical: 14.v,
//                         ),
//                         decoration: AppDecoration.gradientBlackToBlack.copyWith(
//                           borderRadius: BorderRadiusStyle.roundedBorder40,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(top: 7.v),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadiusStyle.roundedBorder40,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                           BorderRadiusStyle.roundedBorder20,
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Espresso",
//                                           style: theme.textTheme.headlineSmall,
//                                         ),
//                                         Text(
//                                           "with chocolate",
//                                           style: CustomTextStyles
//                                               .bodySmallSFProTextWhiteA700,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 21.v),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                           BorderRadiusStyle.roundedBorder8,
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         CustomImageView(
//                                           imagePath: ImageConstant.imgStar2,
//                                           height: 19.adaptSize,
//                                           width: 19.adaptSize,
//                                           radius: BorderRadius.circular(
//                                             9.h,
//                                           ),
//                                           margin: EdgeInsets.only(bottom: 1.v),
//                                         ),
//                                         Container(
//                                           width: 65.h,
//                                           margin: EdgeInsets.only(left: 5.h),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadiusStyle
//                                                 .roundedBorder8,
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 "4.8",
//                                                 style: CustomTextStyles
//                                                     .titleMediumSFProText,
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                   left: 5.h,
//                                                   top: 4.v,
//                                                   bottom: 3.v,
//                                                 ),
//                                                 child: Text(
//                                                   "(6,098)",
//                                                   style: CustomTextStyles
//                                                       .bodySmallSFProTextWhiteA70010,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                 top: 11.v,
//                                 right: 37.h,
//                                 bottom: 5.v,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadiusStyle.roundedBorder37,
//                               ),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     width: 126.h,
//                                     decoration: BoxDecoration(
//                                       borderRadius:
//                                           BorderRadiusStyle.roundedBorder24,
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadiusStyle
//                                                 .roundedBorder20,
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               CustomImageView(
//                                                 imagePath: ImageConstant
//                                                     .imgCoffeeSvgrepoCom,
//                                                 height: 24.adaptSize,
//                                                 width: 24.adaptSize,
//                                                 radius: BorderRadius.circular(
//                                                   12.h,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 11.v),
//                                               Text(
//                                                 "Coffee",
//                                                 style: CustomTextStyles
//                                                     .bodySmallSFProTextGray300,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadiusStyle
//                                                 .roundedBorder24,
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               CustomImageView(
//                                                 imagePath: ImageConstant
//                                                     .imgDropSvgrepoCom,
//                                                 height: 24.adaptSize,
//                                                 width: 24.adaptSize,
//                                                 radius: BorderRadius.circular(
//                                                   12.h,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 11.v),
//                                               Text(
//                                                 "Chocolate",
//                                                 style: CustomTextStyles
//                                                     .bodySmallSFProTextGray300,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: 9.v),
//                                   Text(
//                                     "Medium Roasted",
//                                     style: CustomTextStyles.labelLargeSFProText,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  
//   Widget _buildFrameSeventyOne(BuildContext context) {
//     return SizedBox(
//       height: 32.v,
//       child: ListView.separated(
//         padding: EdgeInsets.only(left: 19.h),
//         scrollDirection: Axis.horizontal,
//         separatorBuilder: (
//           context,
//           index,
//         ) {
//           return SizedBox(
//             width: 15.h,
//           );
//         },
//         itemCount: 5,
//         itemBuilder: (context, index) {
//           return FrameseventyoneItemWidget();
//         },
//       ),
//     );
//   }
// Widget _buildChoiceOption(String optionName, bool selected, String additionalText, String price, void Function(bool)? onChanged) {
//   return Row(
//     children: [
//       Checkbox(
//         value: selected,
//         onChanged: onChanged != null ? (value) => onChanged(value ?? false) : null,
//         activeColor: appTheme.deepOrange800,
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(optionName),
//           SizedBox(height: 4),
//           Text(
//             additionalText,
//             style: TextStyle(fontSize: 12, color: Colors.grey),
//           ),
//         ],
//       ),
//       Spacer(),
//       Text(price),
      
//     ],
//   );
// }

// Widget _buildSelectSize() {
//   return Row(
//     children: [
//       GestureDetector(
//         onTap: () {
//           setState(() {
//             if (selectedSize == "S") {
//               selectedSize = null; 
//             } else {
//               selectedSize = "S"; 
//             }
//           });
//         },
//         child: Container(
//           width: 35.adaptSize,
//           padding: EdgeInsets.symmetric(
//             horizontal: 12.h,
//             vertical: 6.v,
//           ),
//           decoration: BoxDecoration(
//             color: selectedSize == "S" ? appTheme.deepOrange800 :appTheme.gray500Cc,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Center(
//             child: Text(
//               "S",
//               style: TextStyle(
//                 color: selectedSize == "S" ? Colors.white : Colors.black,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           setState(() {
//             if (selectedSize == "M") {
//               selectedSize = null; 
//             } else {
//               selectedSize = "M"; 
//             }
//           });
//         },
//         child: Container(
//           width: 35.adaptSize,
//           margin: EdgeInsets.only(left: 20.h),
//           padding: EdgeInsets.symmetric(
//             horizontal: 10.h,
//             vertical: 6.v,
//           ),
//           decoration: BoxDecoration(
//             color: selectedSize == "M" ? appTheme.deepOrange800 : appTheme.gray500Cc,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Center(
//             child: Text(
//               "M",
//               style: TextStyle(
//                 color: selectedSize == "M" ? Colors.white : Colors.black,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           setState(() {
//             if (selectedSize == "L") {
//               selectedSize = null; 
//             } else {
//               selectedSize = "L"; 
//             }
//           });
//         },
//         child: Container(
//           width: 35.adaptSize,
//           margin: EdgeInsets.only(left: 20.h),
//           padding: EdgeInsets.symmetric(
//             horizontal: 12.h,
//             vertical: 6.v,
//           ),
//           decoration: BoxDecoration(
//             color: selectedSize == "L" ? appTheme.deepOrange800 : appTheme.gray500Cc,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Center(
//             child: Text(
//               "L",
//               style: TextStyle(
//                 color: selectedSize == "L" ? Colors.white : Colors.black,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }



// }




class ProductDetailsPage extends StatefulWidget {


  const ProductDetailsPage({Key? key,}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
    late Future<Map<String, dynamic>> _productDetailsFuture;
  late int productId;
String ?selectedSize;
  @override
  void initState() {
    super.initState();
    _productDetailsFuture = Future.value({});
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
        print('Invalid or zero product ID: $productIdValue');
      }
    } else {
      print('Product ID not found in arguments: $arguments');
    }
  }

void _fetchAndSetProductDetails(int productId) async {
  try {
    final productDetails = await ProductController().getProductWithOptionalMenu(productId);
    setState(() {
      _productDetailsFuture = Future.value(productDetails);
    });
    print('Response Body: $productDetails');
  } catch (error) {
    // Handle error while fetching product details
    print('Error fetching product details: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _productDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final dynamic productData = snapshot.data!['product'];
                final dynamic optionalMenuItemsData = snapshot.data!['optionalMenuItems'];

                if (productData != null && productData is Product) {
                  final Product product = productData as Product;
                 List<OptionalMenu> optionalMenuItems=[];

                  if (optionalMenuItemsData != null && optionalMenuItemsData is List<OptionalMenu>) {
                    optionalMenuItems = optionalMenuItemsData;
                  }

                  return _buildProductDetails(product, optionalMenuItems ?? []);
                } else {
                  return Center(child: Text('Product data is invalid'));
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(Product product, List<OptionalMenu> optionalMenuItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 390,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/product_image_placeholder.jpg'), // Placeholder image
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Icon(Icons.favorite_border, color: Colors.white),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.nameEnglish, 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '\$${product.price}', 
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
              SizedBox(height: 20),
             Padding(
                  padding: EdgeInsets.only(left: 19.h),
                  child: Text(
                    "Description",
                    style: CustomTextStyles.titleSmallGray80001,
                  ),
                ),
              SizedBox(height: 10),
         
               SizedBox(height: 16.v),
                Container(
                  width: 313.h,
                  margin: EdgeInsets.only(left: 19.h),
                  child: ReadMoreText(
                    product.description, 
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    moreStyle: CustomTextStyles.bodySmallInterGray80001.copyWith(
                      height: 1.83,
                    ),
                    lessStyle: CustomTextStyles.bodySmallInterGray80001.copyWith(
                      height: 1.83,
                    ),
                  ),
                ),
              SizedBox(height: 20),
 if (optionalMenuItems.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                  padding: EdgeInsets.only(left: 19.h),
                  child: Text(
                    "Addtional other",
                    style: CustomTextStyles.titleSmallGray80001,
                  ),
                ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: optionalMenuItems.map((menu) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- ${menu.nameEnglish ?? menu.nameArabic}', 
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '\$${menu.price}', // Display price
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 5), // Add spacing between menu items
                        ],
                      );
                    }).toList(),
                  
             ),
                ],
              ),
            
              SizedBox(height: 20),
              Text(
                'Choose Size', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                _buildSelectSize()
                ],
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                        height: 50.v,
                        width: 190.h,
                        text: "Buy Now",
                        margin: EdgeInsets.only(
                          bottom: 4.v,
                        ),
                        buttonStyle: CustomButtonStyles.fillPrimary,
                        buttonTextStyle: CustomTextStyles.titleMediumSFProText,
                      ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectSize() {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          setState(() {
            if (selectedSize == "S") {
              selectedSize = null; 
            } else {
              selectedSize = "S"; 
            }
          });
        },
        child: Container(
          width: 35.adaptSize,
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 6.v,
          ),
          decoration: BoxDecoration(
            color: selectedSize == "S" ? appTheme.deepOrange800 :appTheme.gray500Cc,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              "S",
              style: TextStyle(
                color: selectedSize == "S" ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            if (selectedSize == "M") {
              selectedSize = null; 
            } else {
              selectedSize = "M"; 
            }
          });
        },
        child: Container(
          width: 35.adaptSize,
          margin: EdgeInsets.only(left: 20.h),
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 6.v,
          ),
          decoration: BoxDecoration(
            color: selectedSize == "M" ? appTheme.deepOrange800 : appTheme.gray500Cc,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              "M",
              style: TextStyle(
                color: selectedSize == "M" ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            if (selectedSize == "L") {
              selectedSize = null; 
            } else {
              selectedSize = "L"; 
            }
          });
        },
        child: Container(
          width: 35.adaptSize,
          margin: EdgeInsets.only(left: 20.h),
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 6.v,
          ),
          decoration: BoxDecoration(
            color: selectedSize == "L" ? appTheme.deepOrange800 : appTheme.gray500Cc,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              "L",
              style: TextStyle(
                color: selectedSize == "L" ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
}

  