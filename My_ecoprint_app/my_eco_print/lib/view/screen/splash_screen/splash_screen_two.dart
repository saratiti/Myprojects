import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.lightGreen,
          ),
          Positioned(
            left: 0,
            top: 150,
            right: 150,
            child: SizedBox(
              height: 800.h,
              width: 350.h,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 3.5,
                  sigmaY: 3.5,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgStem,
                  height: 800.h,
                  width: 350.h,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 150,
            right: 150,
            child: SizedBox(
              width: 722,
              height: 722,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 3.5,
                  sigmaY: 3.5,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgLeaf,
                  height: 823,
                  width: 393,
                  alignment: Alignment.topRight,
                ),
              ),
            ),
          ),
          Positioned(
            left: 140,
            top: 169,
            child: SizedBox(
              height: 800.h,
              width: 350.h,
              child: CustomImageView(
                imagePath: ImageConstant.imgStem,
                height: 800.h,
                width: 350.h,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 400,
            bottom: 100,
            child: SizedBox(
              width: 200,
              height: 150,
              child: Transform.scale(
                scale: 3.0,
                child: CustomImageView(
                  imagePath: ImageConstant.imgLeaf,
                  height: 823,
                  width: 393,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(285, 127.19, 501, 221),
            child: CustomImageView(
              imagePath: ImageConstant.imgLeaf,
              height: 1022,
              width: 1022,
            ),
          ),
          _buildContent(context),
        ],
      ),
    );
  }

Widget _buildContent(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0), // Adjusted top padding to 0
                child: CustomImageView(
                  svgPath: ImageConstant.imgFingerprintWhiteA700,
                  height: 200.v, 
                  width: 300.h, 
                  alignment: Alignment.topCenter,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // Added horizontal padding
                child: SizedBox(
                  width: 250.h, // Adjusted width
                  child: Text(
                    "msg".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleLargeWhiteA700.copyWith(height: 1.84),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 100.0),
      Padding(
        padding: const EdgeInsets.only(bottom: 50.0), // Increased padding
        child: CustomOutlinedButton(
          width: 300.h, // Adjusted width
          text: "lbl".tr,
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.loginScreen);
          },
        ),
      ),
    ],
  );
}



}