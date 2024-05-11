

// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';


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
final TextEditingController _commentController=TextEditingController();

  @override
  void initState() {
    super.initState();
    _productDetailsFuture = Future.value({});
     selectedItems = {};
    totalOptionalMenuPrice = 0.0;
    _commentFocusNode = FocusNode();
    showLoadingIndicator = false;
    
  }

void _submitReview(BuildContext context) async {
  if (_commentFocusNode.hasFocus) {
    _commentFocusNode.unfocus(); 
  }

  if (isLoading) return;
  if (comment.isEmpty) {
    EasyLoading.showError('Please enter a comment');
    return;
  }
  if (starRating == 0.0) {
    EasyLoading.showError('Please select a star rating');
    return;
  }

  setState(() {
    isLoading = true;
  });

  EasyLoading.show(status: 'Submitting review...');

  final review = Review(
    comment: comment,
    rating: starRating,
    productId: productId,
  );

  try {
    await ReviewController().create(review);

    EasyLoading.dismiss(); 
    EasyLoading.showSuccess('Review submitted successfully');

    // Clear the text field after submitting the review
    _commentController.clear();
  } catch (error) {
    EasyLoading.dismiss(); 
    EasyLoading.showError('Failed to submit review');
  }

  setState(() {
    isLoading = false;
    comment = '';
    starRating = 0.0;
  });
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

void _fetchAndSetProductDetails(int productId) async {
  try {
    final productDetails = await ProductController().getProductWithOptionalMenu(productId);
    setState(() {
      _productDetailsFuture = Future.value(productDetails);
    });
    if (kDebugMode) {
      print('Response Body: $productDetails');
    }
  } catch (error) {

    if (kDebugMode) {
      print('Error fetching product details: $error');
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
   child: SafeArea(
      child: Scaffold(
        body:
        
        
         SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _productDetailsFuture,
            builder: (context, snapshot) {
               if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final dynamic productData = snapshot.data!['product'];
                final dynamic optionalMenuItemsData =
                    snapshot.data!['optionalMenuItems'];

                if (productData != null && productData is Product) {
                  final Product product = productData;
                  List<OptionalMenu> optionalMenuItems = [];

                  if (optionalMenuItemsData != null &&
                      optionalMenuItemsData is List<OptionalMenu>) {
                    optionalMenuItems = optionalMenuItemsData;
                  }

                  return _buildProductDetails(
                      product, optionalMenuItems);
                } else {
                  return const Center(child: Text('Product data is invalid'));
                }
              }
            },
          ),
        ),
      ),
   ) );
  }

  Widget _buildProductDetails(
    
  Product product, List<OptionalMenu> optionalMenuItems) {
     final localization = AppLocalizationController.to;
    final isEnglish = localization.locale.languageCode == 'en';
  return Consumer<ProductProvider>(
    builder: (context, productProvider, _) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildMask(context),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                isEnglish ? product.nameEnglish.localized : product.nameArabic.localized,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 20, color: appTheme.deepOrange800),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 19.h),
              child: Text(
                "Description",
                style: CustomTextStyles.titleSmallGray80001,
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            if (optionalMenuItems.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 19.h),
                    child: Text(
                      "Additional Options",
                      style: CustomTextStyles.titleSmallGray80001,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    
                    
                    optionalMenuItems.map((menu) {
                      bool isSelected = selectedItems.contains(menu);
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isSelected,
                            activeColor: isSelected
                                ? appTheme.deepOrange800
                                : appTheme.gray100,
                onChanged: (newValue) {
  if (newValue != null) {
    setState(() {
      if (newValue) {
        selectedItems.add(menu);
        totalOptionalMenuPrice += menu.price!;
      } else {
        selectedItems.remove(menu);
        totalOptionalMenuPrice -= menu.price!;
      }
     
      menu.isSelected = newValue;
    });
  }
},


                          ),
                          Text(
                            ' ${menu.nameEnglish ?? menu.nameArabic}',
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? appTheme.deepOrange800
                                  : appTheme.black900,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '\$${menu.price}',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  'Choose Size',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 50),
                Text(
                  "Quantity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildSelectSize(),
                const SizedBox(width: 10),
                _buildQuantitySelector(context, product),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Text(
              'Product Reviews',
              style: CustomTextStyles.titleSmallGray80001,
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Review>>(
              future: ReviewController().getProductReviews(productId),
              builder: (context, snapshot) {
                 if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final reviews = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return ProductReview(review: reviews[index]);
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No reviews available.'),
                  );
                }
              },
            ),
const SizedBox(height: 20),
Text(
  'Leave a Review',
  style: CustomTextStyles.bodySmallInterGray80001,
),
const SizedBox(height: 10),
RatingBar.builder(
  initialRating: starRating,
  minRating: 1,
  direction: Axis.horizontal,
  allowHalfRating: true,
  itemCount: 5,
  itemSize: 30,
  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
  itemBuilder: (context, _) => const Icon(
    Icons.star,
    color: Colors.amber,
  ),
  onRatingUpdate: (rating) {
    setState(() {
      starRating = rating;
    });
  },
),
const SizedBox(height: 10),

Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    border: Border.all(
      width: 1,
      color: const Color.fromARGB(255, 211, 210, 210),
    ),
    color: const Color.fromARGB(255, 204, 203, 203),
  ),
  child: TextFormField(
    focusNode: _commentFocusNode,
    maxLines: 1,
    controller: _commentController, // Add this line
    decoration: InputDecoration(
      labelText: 'Comment',
      labelStyle: const TextStyle(color: Colors.grey),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      suffixIcon: showLoadingIndicator
        ? CircularProgressIndicator()
        : IconButton(
            onPressed: () {
              _submitReview(context);
            },
            icon: Icon(Icons.send, color: Colors.white),
          ),
    ),
    style: const TextStyle(color: Colors.grey),
    // Set cursor color here
    cursorColor: appTheme.deepOrange800,
    onTap: () {
    
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    },
    onChanged: (value) {
      comment = value;
    },
  ),
),



            const SizedBox(height: 20),
            SizedBox(height: 25.v),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: CustomTextStyles.bodyMediumInterGray60001,
                      ),
                      SizedBox(height: 3.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\$${(product.price + totalOptionalMenuPrice) * productProvider.getCartItemQuantity(product)}",
                            style: CustomTextStyles.headlineSmallInterGray80001,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      _addToCart(context, product, optionalMenuItems);
                          showSummaryInvoice(context);
                    },
                    height: 50.v,
                    width: 190.h,
                    text: "Buy Now",
                    margin: EdgeInsets.only(bottom: 4.v),
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle: CustomTextStyles.titleMediumSFProText,
                 ),
              ],
            ),
          ),
        ],
      ))]);
    },
  );
}
  Widget _buildSelectSize() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedSize = "S";
            });
          },
          child: Container(
            width: 35.adaptSize,
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 6.v,
            ),
            decoration: BoxDecoration(
              color: selectedSize == "S" ? appTheme.deepOrange800 : appTheme.gray500Cc,
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
              selectedSize = "M";
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
              selectedSize = "L";
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

Widget _buildQuantitySelector(BuildContext context, Product product) {
  return Consumer<ProductProvider>(
    builder: (context, productProvider, _) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              productProvider.decrementQuantity(product);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            product.selectedQty.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              productProvider.incrementQuantity(product);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      );
    },
  );
}

    Widget _buildMask(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 390.v,
        width: 388.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
        
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 390.v,
                width: 388.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 383.v,
                        width: 388.h,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgImg383x388,
                              height: 383.v,
                              width: 388.h,
                              radius: BorderRadius.circular(
                                40.h,
                              ),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    25.h, 18.v, 34.h, 329.v),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                GestureDetector(
  onTap: () {
    Navigator.of(context).pop();
  },
  child: CustomIconButton(
    height: 35.adaptSize,
    width: 35.adaptSize,
    padding: EdgeInsets.all(6.h),
    child: CustomImageView(
      imagePath: ImageConstant.imgArrowLeft,
    ),
  ),
),

                                    CustomIconButton(
                                      height: 35.adaptSize,
                                      width: 35.adaptSize,
                                      padding: EdgeInsets.all(6.h),
                                      decoration:
                                          IconButtonStyleHelper.fillWhiteATL17,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgHeart,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 269.v),
                        padding: EdgeInsets.symmetric(
                          horizontal: 27.h,
                          vertical: 14.v,
                        ),
                        decoration: AppDecoration.gradientBlackToBlack.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 7.v),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusStyle.roundedBorder40,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Espresso",
                                          style: theme.textTheme.headlineSmall,
                                        ),
                                        Text(
                                          "with chocolate",
                                          style: CustomTextStyles
                                              .bodySmallSFProTextWhiteA700,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 21.v),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder8,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgStar2,
                                          height: 19.adaptSize,
                                          width: 19.adaptSize,
                                          radius: BorderRadius.circular(
                                            9.h,
                                          ),
                                          margin: EdgeInsets.only(bottom: 1.v),
                                        ),
                                        Container(
                                          width: 65.h,
                                          margin: EdgeInsets.only(left: 5.h),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder8,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "4.8",
                                                style: CustomTextStyles
                                                    .titleMediumSFProText,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 5.h,
                                                  top: 4.v,
                                                  bottom: 3.v,
                                                ),
                                                child: Text(
                                                  "(6,098)",
                                                  style: CustomTextStyles
                                                      .bodySmallSFProTextWhiteA70010,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 11.v,
                                right: 37.h,
                                bottom: 5.v,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusStyle.roundedBorder37,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 126.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder24,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder20,
                                          ),
                                          child: Column(
                                            children: [
                                              CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgCoffeeSvgrepoCom,
                                                height: 24.adaptSize,
                                                width: 24.adaptSize,
                                                radius: BorderRadius.circular(
                                                  12.h,
                                                ),
                                              ),
                                              SizedBox(height: 11.v),
                                              Text(
                                                "Coffee",
                                                style: CustomTextStyles
                                                    .bodySmallSFProTextGray300,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder24,
                                          ),
                                          child: Column(
                                            children: [
                                              CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgDropSvgrepoCom,
                                                height: 24.adaptSize,
                                                width: 24.adaptSize,
                                                radius: BorderRadius.circular(
                                                  12.h,
                                                ),
                                              ),
                                              SizedBox(height: 11.v),
                                              Text(
                                                "Chocolate",
                                                style: CustomTextStyles
                                                    .bodySmallSFProTextGray300,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 9.v),
                                  Text(
                                    "Medium Roasted",
                                    style: CustomTextStyles.labelLargeSFProText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  


void _addToCart(BuildContext context, Product product, List<OptionalMenu> selectedOptions) {
  final productProvider = Provider.of<ProductProvider>(context, listen: false);
  productProvider.addToCart(product, selectedOptions);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to Cart')));
}






}


