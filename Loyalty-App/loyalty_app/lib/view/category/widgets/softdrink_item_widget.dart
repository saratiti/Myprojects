import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class SoftdrinkItemWidget extends StatelessWidget {
  const SoftdrinkItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 122.h,
      child: Padding(
        padding: EdgeInsets.only(top: 1.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 122.adaptSize,
              width: 122.adaptSize,
              padding: EdgeInsets.symmetric(
                horizontal: 31.h,
                vertical: 3.v,
              ),
              decoration: AppDecoration.outlineBlueGrayAd.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgRectangle39,
                height: 89.v,
                width: 60.h,
                alignment: Alignment.topCenter,
              ),
            ),
            SizedBox(height: 22.v),
            Padding(
              padding: EdgeInsets.only(left: 24.h),
              child: Text(
                "SoftDrink",
                style: theme.textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
