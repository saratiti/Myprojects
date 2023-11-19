// ignore_for_file: unused_local_variable
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ncej_admin/core/app_export.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.lightGreen,
          child: Stack(alignment: Alignment.center, children: [
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
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    svgPath: ImageConstant.imgFingerprintWhiteA700,
                    height: 163.v,
                    width: 289.h,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 150.v),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 214.h,
                      margin: EdgeInsets.only(top: 1.v),
                      child: Text(
                        "msg".tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.titleLargeWhiteA700.copyWith(
                          height: 1.84,
                        ),
                      ),
                    ),
                  ),
                ]),
            Align(
              alignment: Alignment.topCenter,
              child: CustomOutlinedButton(
                width: 236.h,
                text: "lbl".tr,
                margin: EdgeInsets.only(bottom: 80.v),
                alignment: Alignment.bottomCenter,
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.loginScreen);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
