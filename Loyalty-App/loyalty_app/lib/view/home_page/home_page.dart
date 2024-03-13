import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/view/home_page/widgets/subCategory_item_widget.dart';
import 'package:loyalty_app/view/home_page/widgets/slider_item_widget.dart';
import 'package:loyalty_app/widgets/app_bar/custom_bottom_bar.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/app_export.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  int sliderIndex = 1;
  int userPoints = 2000;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillGray,
            child: Column(
              children: [
                _buildAppBar(context),
                SizedBox(height: 150.v, child: _buildCardWidget(context)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgClose,
                              height: 31.v,
                              width: 39.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 17.h,
                                top: 2.v,
                              ),
                              child: Text(
                                "What’s in Today?",
                                style: CustomTextStyles.titleMediumPoppinsGray900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.v),
                      _buildSlider(context),
                      SizedBox(height: 28.v),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 6.v,
                          child: AnimatedSmoothIndicator(
                            activeIndex: sliderIndex,
                            count: 2,
                            axisDirection: Axis.horizontal,
                            effect: ScrollingDotsEffect(
                              spacing: 4,
                              activeDotColor: appTheme.deepOrange800,
                              dotColor: appTheme.deepOrange800,
                              dotHeight: 6.v,
                              dotWidth: 6.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 17.v),
                      _buildTextCategory(context),
                      SizedBox(height: 19.v),
                      _buildCategory(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(onChanged: (selectedType) => handleBottomNavChange(context, selectedType)),
      ),
    );
  }

Widget _buildAppBar(BuildContext context) {
  Color userLevelColor = Colors.grey;
  double progress = (userPoints / 1000.0).clamp(0.0, 1.0);

  if (userPoints >= 1000) {
    userLevelColor = Colors.amber;
  } else if (userPoints >= 500) {
    userLevelColor = Colors.grey;
  } else if (userPoints <= 500) {
    userLevelColor = Colors.brown;
  }

  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15.v),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepOrange[700]!, 
            Colors.deepOrange[900]!, 
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgMegaphone,
                  height: 30.v,
                  width: 38.h,
                  margin: EdgeInsets.only(
                    top: 5.v,
                    bottom: 1.v,
                  ),
                  color: Colors.white,
                  // Add additional styling here if needed
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgBell,
                  height: 38.v,
                  width: 54.h,
                  color: Colors.white,
                  // Add additional styling here if needed
                ),
              ],
            ),
          ),
          SizedBox(height: 20.v),
          Container(
            margin: EdgeInsets.only(
              left: 5.h,
              right: 7.h,
            ),
            padding: EdgeInsets.symmetric(vertical: 8.v),
            child: Column(
              children: [
                SizedBox(height: 10.v),
                CircularPercentIndicator(
                  radius: 80.v,
                  lineWidth: 8.0,
                  percent: progress,
                  backgroundColor: Colors.grey,
                  progressColor: userLevelColor,
                  center: Text(
                    userPoints >= 1000 ? 'Gold Level' : 'Silver Level',
                    style: TextStyle(
                      color: userLevelColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8.v),
                Text(
                  'Currently you have $userPoints points ${userPoints >= 1000 ? 'Gold' : 'Silver'} Level',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
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


  Widget _buildSlider(BuildContext context) {
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

  Widget _buildTextCategory(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.h,
        right: 34.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgClose,
                height: 31.v,
                width: 39.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 3.v,
                ),
                child: Text(
                  "Popular categories",
                  style: CustomTextStyles.titleMediumPoppinsGray900,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.v,
              bottom: 7.v,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.categoryScreen);
              },
              child: Text(
                "See all",
                style: CustomTextStyles.bodyMediumMerriweatherBlack90001,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWidget(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 243, 239, 239).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCircleContainer(
              icon: Icons.qr_code,
              text: 'QR Code',
              onTap: () {},
            ),
            _buildCircleContainer(
              icon: Icons.receipt,
              text: 'Receipt Voucher',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.receiptScreen);
              },
            ),
            _buildCircleContainer(
              icon: Icons.group,
              text: 'Invite Persons',
              onTap: () {
                 Navigator.pushNamed(context, AppRoutes.inviteFriendsScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleContainer({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD1512D),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(BuildContext context) {
    return SizedBox(
      height: 159.v,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 13.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 1.h,
          );
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return SubCategoryWidget();
        },
      ),
    );
  }

  void handleBottomNavChange(BuildContext context, BottomBarEnum selectedType) {
    switch (selectedType) {
      case BottomBarEnum.Home:
        navigateToRewordScreen(context);
        break;
      case BottomBarEnum.Scanpay:
        navigateToScanCodeScreen(context);
        break;
      case BottomBarEnum.Reword:
        navigateToRewordScreen(context);
        break;
      case BottomBarEnum.Order:
        navigateToLoginScreen(context);
        break;
      default:
    }
  }

  void navigateToRewordScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.rewordScreen);
  }

  void navigateToScanCodeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.homeScreen);
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.homeScreen);
  }
}
