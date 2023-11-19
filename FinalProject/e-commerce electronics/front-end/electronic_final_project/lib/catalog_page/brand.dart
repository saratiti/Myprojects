import 'package:electronic_final_project/controller/brand.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/brand.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/product/product_card_item_widget.dart';
import 'package:electronic_final_project/theme/app_decoration.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:electronic_final_project/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class BrandPage extends StatelessWidget {
  final int brandId;
  final int categoryId;
  final Brand brand;

  const BrandPage({
    required this.brandId,
    required this.categoryId,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.infinity,
          decoration: AppDecoration.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildCustomAppBar(context),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                
                ],
              ),
              Padding(
                padding: getPadding(top: 14),
                child: Text(
                  "",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtSFUIDisplayMedium13,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: getPadding(left: 16, top: 14, right: 16),
                  child: FutureBuilder<List<Product>>(
                    future: BrandController()
                        .getProductsByBrandAndCategory(brandId, categoryId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Product> products = snapshot.data!;
                        return Container(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              Product product = products[index];
                              return GestureDetector(
                                onTap: () {
                                  navigateToProductDetails(context, product);
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 2.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      product.price.toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppStyle
                                                          .txtSFUIDisplaySemibold14,
                                                    ),
                                                    SizedBox(width: 4.0),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                            offset:
                                                                Offset(0, 2),
                                                            blurRadius: 4.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: CustomImageView(
                                                        svgPath: ImageConstant
                                                            .imgArrowdown,
                                                        height:
                                                            getVerticalSize(13),
                                                        width:
                                                            getHorizontalSize(
                                                                15),
                                                        margin: getMargin(
                                                            left: 2,
                                                            top: 1,
                                                            bottom: 1),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 3.0),
                                                Text(
                                                  product.brand.brand_name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppStyle
                                                      .txtSFUIDisplayRegular14Gray600,
                                                ),
                                                SizedBox(height: 3.0),
                                                Text(
                                                  product.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppStyle
                                                      .txtSFUIDisplayMedium14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomAppBar(BuildContext context) {
    return CustomAppBar(
      height: getSize(56),
      centerTitle: true,
      title: Column(
        children: [
          Padding(
            padding: getPadding(left: 10, right: 11, bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppbarImage(
                  height: getSize(24),
                  width: getSize(24),
                  margin: getMargin(top: 10, right: 30),
                  svgPath: ImageConstant.imgArrowleftBlueGray900,
                  onTap: () {
                    onTapArrowLeft(context);
                  },
                ),
                AppbarTitle(
                  text: brand.brand_name,
                  margin: getMargin(left: 100, top: 10),
                ),
                AppbarImage(
                  height: getSize(24),
                  width: getSize(24),
                  svgPath: ImageConstant.imgSearchBlueGray900,
                  margin: getMargin(left: 100, top: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  void navigateToProductDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }
}

