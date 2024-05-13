import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double desiredHeightRatio = 1.8;
    double desiredWidthRatio = 1.7;

    double imageTopPadding = 190.0;

    return Scaffold(
      backgroundColor: appTheme.lightGreen500,
      body: Center(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: imageTopPadding.h),
                child: Transform.scale(
                  scale: desiredWidthRatio,
                  alignment: Alignment.centerRight,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgsplashScreen,
                    fit: BoxFit.contain,
                    height: screenHeight * desiredHeightRatio,
                    width: screenWidth * desiredWidthRatio,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildContent(context), // Show the content immediately
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 270),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              "msg".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.titleLargeWhiteA700.copyWith(height: 1.84),
            ),
          ),
        ),
        SizedBox(height: 160),
        CustomOutlinedButton(
          width: MediaQuery.of(context).size.width * 0.6,
          text: "lbl".tr,
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.loginScreen);
          },
        ),
      ],
    );
  }
}
