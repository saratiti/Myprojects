import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.v),
        child: Column(
          children: [
            ClipOval(
              child: CustomImageView(
                imagePath: ImageConstant.imgImg,
                height: 120.adaptSize,
                width: 120.adaptSize,
              ),
            ),
            SizedBox(height: 7.v),
            Text(
              "Halloween Treats",
              style: CustomTextStyles.labelLargeProximaNovaBluegray900,
            ),
          ],
        ),
      ),
    );
  }
}
