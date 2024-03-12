import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';


// ignore: must_be_immutable
class ReceiptoneItemWidget extends StatelessWidget {
  const ReceiptoneItemWidget({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
      width: 317.h,
      padding: EdgeInsets.symmetric(
        horizontal: 23.h,
        vertical: 14.v,
      ),
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.h), // Adjust border radius for custom shape
          bottomRight: Radius.circular(30.h), // Adjust border radius for custom shape
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            spreadRadius: 2.h,
            blurRadius: 5.h,
            offset: Offset(0, 3.h), // Shadow offset
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgReceipt,
            height: 90.v,
            width: 76.h,
            radius: BorderRadius.horizontal(
              left: Radius.circular(6.h),
            ),
          ),
          SizedBox(width: 10.h), // Add spacing between image and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Receipt1",
                style: theme.textTheme.titleLarge,
              ),
              Text(
                "Ice Coffee",
                style: CustomTextStyles.labelLargeBlack90001,
              ),
              // Add any other widgets you'd like here
            ],
          ),
        ],
      ),
    );
  }
}