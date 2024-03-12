


import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/view/rewords/widgets/points_item_widget.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            
             
              Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  right: 73.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Text(
                        "Today",
                        style: CustomTextStyles.labelLargeGray600,
                      ),
                    ),
                    Text(
                      "Clear All",
                      style: CustomTextStyles.labelLargeGray600,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36.v),
              _buildPoints(context),
              SizedBox(height: 69.v),
              Padding(
                padding: EdgeInsets.only(left: 30.h),
                child: Text(
                  "Yesterday",
                  style: CustomTextStyles.labelLargeGray600,
                ),
              ),
              SizedBox(height: 5.v),
               _buildPoints1(context),
        ],
      ),
     
    );
  }
Widget _buildPoints(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 42.v,
            );
          },
          itemCount: 2,
          itemBuilder: (context, index) {
            return PointsItemWidget();
          },
        ),
      ),
    );
  }


  Widget _buildPoints1(BuildContext context) {
   return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 111.v,
        width: 400.h,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(right: 6.h),
                padding: EdgeInsets.all(9.h),
                decoration: AppDecoration.outlineBlack,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImg120x120,
                      height: 92.v,
                      width: 107.h,
                      radius: BorderRadius.circular(
                        8.h,
                      ),
                      margin: EdgeInsets.only(bottom: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 34.h,
                        top: 24.v,
                        bottom: 19.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "SOftDrink",
                              style: CustomTextStyles.labelLargeBlack900,
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Text(
                            "You just earned 10 points!",
                            style: CustomTextStyles.labelLargeGray600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
          top: 0,
          right: 0,
          child: CustomElevatedButton(
          width: 160.h,
          text: "+10points",
         
          alignment: Alignment.topRight,
        ),
        ),
          ],
        ),
      ),
    );
  }
}


