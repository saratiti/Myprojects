import 'package:electronic_final_project/catalog_page/brand.dart';
import 'package:electronic_final_project/catalog_page/widgets/catalog_item_widget.dart';
import 'package:electronic_final_project/controller/brand.dart';
import 'package:electronic_final_project/controller/category.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/brand.dart';
import 'package:electronic_final_project/model/category.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/product/product_card_item_widget.dart';
import 'package:electronic_final_project/search/search.dart';
import 'package:electronic_final_project/theme/app_decoration.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:electronic_final_project/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class CatalogPage extends StatelessWidget {
  final int categoryId;
  final Category categories;

  CatalogPage({required this.categoryId, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.infinity,
          decoration: AppDecoration.white,
          child: Column(
            children: [
              buildCustomAppBar(context),
              Divider(),
              Expanded(
                child: Padding(
                  padding: getPadding(left: 10, right: 13),
                  child: Column(
                    children: [
                      Expanded(child: getBrand(context)),
                      SizedBox(height: 20),
                      Divider(),
                      Expanded(
                        flex: 4,
                        child: FutureBuilder<List<Product>>(
                          future: CategoryController().getProductsByCategory(categoryId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<Product> products = snapshot.data!;

                              return GridView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: getVerticalSize(17),
                                  crossAxisSpacing: getHorizontalSize(20),
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  Product product = products[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailsPage(product: product),
                                        ),
                                      );
                                    },
                                    child: CatalogItemWidget(product: product),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),


        ),
                        bottomNavigationBar: CustomBottomBar(
  onChanged: (item) {
    navigateToPage(context, item);
  },
  selectedBottomBarItem: BottomBarEnum.Search, 
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
            padding: getPadding( right: 8, bottom: 3),
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
                  text: categories.name,
                  margin: getMargin(left: 100, top: 10),
                ),
                AppbarImage(
                  height: getSize(24),
                  width: getSize(24),
                  svgPath: ImageConstant.imgSearchBlueGray900,
                   onTap: () {
                    onTapSearch(context);
                  },
                  margin: getMargin(left: 100, top: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBrand(BuildContext context) {
    return FutureBuilder<List<Brand>>(
      future: BrandController().getBrandsByCategoryId(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Brand> brands = snapshot.data!;
          List<List<Brand>> brandGroups = [];
          for (int i = 0; i < brands.length; i += 3) {
            int endIndex = i + 3;
            if (endIndex > brands.length) {
              endIndex = brands.length;
            }
            brandGroups.add(brands.sublist(i, endIndex));
          }
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              padding: getPadding(
                left: 16,
                top: 8,
                right: 16,
                bottom: 14,
              ),
              decoration: AppDecoration.white,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 120 / 47,
                children: [
                  for (var group in brandGroups)
                    for (var brand in group)
                      Padding(
                        padding: EdgeInsets.all(8.0), 
                        child: ElevatedButton(
                          onPressed: () {
                            handleBrandTapped(context, brand.id, categories.id,brand);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstant.gray100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: Image.network(
                            brand.image,
                            width: getHorizontalSize(200),
                            height: getVerticalSize(200),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          );
        }
      },
    );
    
  }
void handleBrandTapped(BuildContext context, int brandId, int categoryId,Brand brand) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BrandPage(
        brandId: brandId,
        categoryId: categoryId, brand: brand,
        
      ),
    ),
  );
}


  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
  
void onTapSearch(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SearchScreen()),
  );
}

}
