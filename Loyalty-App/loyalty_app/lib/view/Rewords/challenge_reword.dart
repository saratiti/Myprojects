import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 54.v),
                Padding(
                  padding: EdgeInsets.only(left: 13.h),
                  child: Text(
                    "AVAILABLE CHALLENGES",
                    style: CustomTextStyles.labelLargeGray600,
                  ),
                ),
                SizedBox(height: 49.v),
                _buildPoints(context),
                SizedBox(height: 85.v),
                _buildChallengeCompleted(context),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPoints(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 11.h),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(right: 2.h),
              padding: EdgeInsets.symmetric(vertical: 13.v),
              decoration: AppDecoration.outlineBlack.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 22.h),
                    child: Text(
                      "Invite 10 New Friends",
                      style: CustomTextStyles.labelLargeBlack900,
                    ),
                  ),
                  SizedBox(height: 23.v),
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle34,
                          height: 56.v,
                          width: 89.h,
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 12.h,
                            ),
                            child: Text(
                              "Invite 10 new friends to join our app and get 100 points to use in amazing rewards!",
                              style: CustomTextStyles.labelLargeBlack900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 23.v),
                  Padding(
                    padding: EdgeInsets.only(left: 3.h, right: 13.h),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            height: 22.v,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.h),
                              gradient: LinearGradient(
                                begin: Alignment(0.45, 0.5),
                                end: Alignment(0.69, 0.5),
                                colors: [
                                  appTheme.deepOrangeA700E5,
                                  appTheme.blueGray100.withOpacity(0.9),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 11.h, top: 3.v, bottom: 2.v),
                          child: Text(
                            "6/10",
                            style: CustomTextStyles.labelLargeInterBlack900Medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.v),
                ],
              ),
            ),
          ),
          CustomElevatedButton(
            width: 160.h,
            text: "+100 Points",
            margin: EdgeInsets.only(top: 7.v),
            alignment: Alignment.topRight,
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCompleted(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 11.h),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(right: 2.h),
              padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 22.v),
              decoration: AppDecoration.outlineBlack.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.h),
                    child: Text(
                      "3 Daily Purchases",
                      style: CustomTextStyles.labelLargeBlack900,
                    ),
                  ),
                  SizedBox(height: 15.v),
                  Padding(
                    padding: EdgeInsets.only(right: 51.h),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle35,
                          height: 57.v,
                          width: 88.h,
                        ),
                        Flexible(
                          child: Container(
                            width: 225.h,
                            margin: EdgeInsets.only(left: 18.h, top: 5.v),
                            child: Text(
                              "Visit our store daily and make purchase of at least 4 for 3 days straight!",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: CustomTextStyles.labelLargeBlack900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 27.v),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 22.v,
                      width: 354.h,
                      decoration: BoxDecoration(
                        color: appTheme.redA100E5,
                        borderRadius: BorderRadius.circular(11.h),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomElevatedButton(
            width: 160.h,
            text: "Challenge Completed",
            margin: EdgeInsets.only(top: 11.v),
            alignment: Alignment.topRight,
          ),
        ],
      ),
    );
  }
}
