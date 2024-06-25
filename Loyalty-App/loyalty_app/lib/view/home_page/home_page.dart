// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:share/share.dart';



class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  int sliderIndex = 1;
  int userPoints = 2000;

  @override
  Widget build(BuildContext context) {
        mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
   child:SafeArea(
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
                                "lbl20".localized,
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
                     SubCategoryWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(onChanged: (selectedType) => handleBottomNavChange(context, selectedType)),
      ),
  ));
  }

Widget _buildAppBar(BuildContext context) {
  return FutureBuilder<Map<String, dynamic>>(
    future:LoyaltyController().getLoyaltyDataByUser(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) { 
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        
        String loyaltyLevel = snapshot.data?['loyaltyLevel'] ?? '';
        int userPoints = snapshot.data?['loyaltyPoint'] ?? 0;
        Color userLevelColor = snapshot.data?['userLevelColor'] ?? Colors.grey;

        double progress = (userPoints / 1000.0).clamp(0.0, 1.0);

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
                  offset: const Offset(0, 3),
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
                      GestureDetector(
                        onTap: () {
                          _showNavigationMenu(context);
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.imgMegaphone,
                          height: 30.v,
                          width: 38.h,
                          margin: EdgeInsets.only(
                            top: 5.v,
                            bottom: 1.v,
                          ),
                          color: Colors.white,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgBell,
                        height: 38.v,
                        width: 54.h,
                        color: Colors.white,
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
                          loyaltyLevel.isNotEmpty ? '$loyaltyLevel Level' : 'No Level',
                          style: TextStyle(
                            color: userLevelColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.v),
                      Text(
                        loyaltyLevel.isNotEmpty
                            ? 'Currently you have $userPoints points $loyaltyLevel Level'
                            : 'No loyalty data available',
                        style: const TextStyle(
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
    },
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
              return const SliderWidget();
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
        right: 2.h,
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
                  "lbl_20".localized,
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
                "lbl22".localized,
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
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 243, 239, 239).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCircleContainer(
              icon: Icons.qr_code,
              text: 'QR Code',
              onTap: () { Navigator.pushNamed(context, AppRoutes.scannerScreen);},
            ),
            // _buildCircleContainer(
            //   icon: Icons.receipt,
            //   text: 'Receipt Voucher',
            //   onTap: () {
            //     Navigator.pushNamed(context, AppRoutes.receiptScreen);
            //   },
            // ),
            _buildCircleContainer(
              icon: Icons.group,
              text: 'Invite Persons',
              onTap: () {
            _shareInviteLink(context);
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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD1512D),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }


  void _showNavigationMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CircularNavigationMenu(
          onProfilePressed: () {
          
          },
          onInvitePressed: () {
            
          },
          onLogoutPressed: () {
           
          },
        );
      },
    );
  }


  void handleBottomNavChange(BuildContext context, BottomBarEnum selectedType) {
    switch (selectedType) {
      case BottomBarEnum.Home:
        navigateToHomeScreen(context);
        break;
      case BottomBarEnum.Scanpay:
        navigateToScanCodeScreen(context);
        break;
      case BottomBarEnum.Reword:
        navigateToRewordScreen(context);
        break;
      case BottomBarEnum.Order:
        navigateToOrderScreen(context);
        break;
      default:
    }
  }
  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.homeScreen);
  }
  void navigateToRewordScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.rewordScreen);
  }

  void navigateToScanCodeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.scannerScreen);
  }

  void navigateToOrderScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.orderScreen);
  }
    void _shareInviteLink(BuildContext context) {

    const String text = 'https://play.google.com/store/apps/details?id=com.facebook.katana&hl=en_US';

    Share.share(text);
  }
}
