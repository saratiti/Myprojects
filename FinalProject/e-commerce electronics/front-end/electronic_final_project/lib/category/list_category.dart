
import 'package:electronic_final_project/catalog_page/catalog_page.dart';

import 'package:electronic_final_project/search/search.dart';
import 'package:flutter/material.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';

import 'package:electronic_final_project/theme/app_style.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:electronic_final_project/widgets/custom_bottom_bar.dart';
import 'package:electronic_final_project/controller/category.dart';
import 'package:electronic_final_project/model/category.dart';


class CategoriesScreen extends StatefulWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final List<Category> categories;
 

  CategoriesScreen({required this.categories});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future<List<Category>> fetchCategories() async {
    return await CategoryController().getAll();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: getVerticalSize(100),
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomAppBar(
                      height: getVerticalSize(50),
                      centerTitle: true,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(left: 8, right: 11,top:10),
                            
                            child: Row(
                              children: [
                                AppbarImage(
                                  height: getSize(24),
                                  width: getSize(24),
                                  svgPath: ImageConstant.imgArrowleftBlueGray900,
                                  margin: getMargin(bottom: 1,top: 10),
                                  onTap: () {
                                    onTapArrowleft(context);
                                  },
                                ),
                                AppbarTitle(
                                  text: "Categories",
                                  margin: getMargin(left: 113, top: 10),
                                ),
                                AppbarImage(
                                  height: getSize(24),
                                  width: getSize(24),
                                  svgPath: ImageConstant.imgSearchBlueGray900,
                                  onTap: () {
                                    onTapSearch(context);
                                  },
                                  margin: getMargin(left: 110, bottom: 1,top:10),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: getPadding(top: 10),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Divider(
                                height: getVerticalSize(1),
                                thickness: getVerticalSize(1),
                                color: ColorConstant.black9000c,
                              ),
                            ),
                          ),
                        ],
                      ),
                      styleType: Style.bgFillBlack9000c,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withOpacity(0.1),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: FutureBuilder<List<Category>>(
                    future: fetchCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Category> categories = snapshot.data!;
                    return ListView.builder(
  itemCount: categories.length,
  itemBuilder: (context, index) {
    Category category = categories[index];
    
  return GestureDetector(
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CatalogPage(categoryId:category.id,  categories:category,)),
  );
},


  child: Container(
    height: getVerticalSize(100),
    width: getHorizontalSize(344),
    margin: getMargin(top: 16),
    decoration: BoxDecoration(
      color:Color.fromARGB(255, 236, 235, 235),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF000000).withOpacity(0.1),
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.centerRight,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: getMargin(right: 5),
            padding: getPadding(left: 20, top: 40, right: 50, bottom: 40),
            child: Center(
              child: SizedBox(
                width: getHorizontalSize(150),
                child: Text(
                  category.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtSFUIDisplaySemibold15,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Image.network(
            category.image ?? '',
            height: getVerticalSize(100),
            width: getHorizontalSize(100),
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  ),
);


  },
);

                      }
                    },
                    
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
 
  void onTapArrowleft(BuildContext context) {
    Navigator.of(context).pop();
  }
  void onTapSearch(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SearchScreen()),
  );
}
}




