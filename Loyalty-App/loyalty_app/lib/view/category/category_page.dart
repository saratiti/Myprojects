
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_app/controller/loyalty.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/view/category/widgets/softdrink1_item_widget.dart';
import 'package:loyalty_app/view/category/widgets/softdrink_item_widget.dart';
import 'package:loyalty_app/view/category/widgets/top_product.dart';
import 'package:loyalty_app/view/home_page/widgets/slider_item_widget.dart';
import 'package:loyalty_app/widgets/app_bar/custom_app_bar.dart';
import 'package:loyalty_app/widgets/custom_icon_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int userPoints = 2000;
  bool showTopProducts = true; 
 void toggleTopProductsVisibility(bool showTopProducts) {
    setState(() {
      showTopProducts = showTopProducts;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildZipcode(context, userPoints),
              SizedBox(height: 46.v),
              _buildSlider(context),
              SizedBox(height: 90.v),
            if (showTopProducts) // Only show if _showTopProducts is true
              
              SoftdrinkItemWidget(
                toggleTopProductsVisibility: toggleTopProductsVisibility,
              ),
                SizedBox(height: 46.v),
                  TopRatedProducts(),
              
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        elevation: 0,
        leadingWidth: 40.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appTheme.deepOrange800,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        title: Text(
          "Category",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    int sliderIndex = 1;

    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 17.h,
      ),
      child: Column(
        children: [
          SizedBox(height: 20.v),
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 86.v,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                sliderIndex = index;
              },
            ),
            itemCount: 2,
            itemBuilder: (context, index, realIndex) {
              return SliderWidget();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildZipcode(BuildContext context, int userPoints) {
    return FutureBuilder<Map<String, dynamic>>(
      future: LoyaltyController().getLoyaltyDataByUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          int userPoints = snapshot.data?['loyaltyPoint'] ?? 0;
          String userLevel = snapshot.data?['loyaltyLevel'] ?? 'Unknown';

          String medalImage;
          String medalText;
          double progress = 0.0;

          if (userPoints >= 2000) {
            medalImage = ImageConstant.imgGoldMedal;
            medalText = "Gold Medal";
            progress = 1.0;
          } else if (userPoints >= 1000) {
            medalImage = ImageConstant.imgSilverMedal;
            medalText = "Silver Medal";
            progress = (userPoints - 1000) / 1000;
          } else {
            medalImage = ImageConstant.imgBronzeMedal;
            medalText = "Bronze Medal";
            progress = userPoints / 1000;
          }

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Image.asset(
                      medalImage,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medalText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Available Points: $userPoints",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Level: $userLevel",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20), // Adjust vertical padding
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(appTheme.deepOrange800),
                            minHeight: 10,
                          ),
                        ),
                      ],
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
}




  
  


  // Widget _buildSoftDrink1(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(right: 6.h),
  //     child: ListView.separated(
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       separatorBuilder: (
  //         context,
  //         index,
  //       ) {
  //         return SizedBox(
  //           height: 18.v,
  //         );
  //       },
  //       itemCount: 4,
  //       itemBuilder: (context, index) {
  //         return Softdrink1ItemWidget();
  //       },
  //     ),
  //   );
  // }
