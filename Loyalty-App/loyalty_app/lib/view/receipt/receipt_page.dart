

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/view/receipt/widgets/receiptone_item_widget.dart';
import 'package:loyalty_app/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:loyalty_app/widgets/custom_bottom_bar.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class Receiptpage extends StatelessWidget {
  const Receiptpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 5.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 31.v),
                      _buildReceiptOne(context),
                      SizedBox(height: 353.v),
    CustomElevatedButton(
  height: 55.v,
  width: 147.h,
  text: "Upload",
  leftIcon: Container(
    margin: EdgeInsets.only(right: 7.h),
    child: CustomImageView(
      imagePath: ImageConstant.imgUploadIcon,
      height: 43.v,
      width: 32.h,
       onTap: () {

          Navigator.pushNamed(context, AppRoutes.receiptUploadScreen);
        

            },
    ),
  ),
  buttonStyle: CustomButtonStyles.outlineBlueTL27,
  buttonTextStyle: CustomTextStyles.labelLargeInterBlack90001.copyWith(color: Colors.white), // Set text color to white
  alignment: Alignment.centerRight,
)

                    ]))));
  }


  Widget _buildReceiptOne(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 45.h, right: 58.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 44.v);
            },
            itemCount: 2,
            itemBuilder: (context, index) {
              return ReceiptoneItemWidget();
            }));
  }

  /// Navigates back to the previous screen.
  onTapVector(BuildContext context) {
    Navigator.pop(context);
  }
}
