import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/widgets/custom_icon_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class Softdrink1ItemWidget extends StatelessWidget {
  const Softdrink1ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProduct02(
              context,
              softDrink: "SoftDrink 1",
              cafenioRestaurant: "Restaurant 1",
              price: "40",
              rating: 4.5,
            ),
            SizedBox(width: 40),
            _buildProduct02(
              context,
              softDrink: "SoftDrink 2",
              cafenioRestaurant: "Restaurant 2",
              price: "60",
              rating: 3.8, 
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProduct02(
  BuildContext context, {
  required String softDrink,
  required String cafenioRestaurant,
  required String price,
  required double rating,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, AppRoutes.productDetailsScreen);
    },
    child: SizedBox(
      height: 190.v,
      width: 166.h,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 13.h,
                  vertical: 10.v,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 39.v),
                    Text(
                      softDrink,
                      style: CustomTextStyles.titleSmallSenBluegray90001.copyWith(
                        color: appTheme.blueGray90001,
                      ),
                    ),
                    SizedBox(height: 5.v),
                    Text(
                      cafenioRestaurant,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: appTheme.blueGray600,
                      ),
                    ),
                    SizedBox(height: 3.v),
                    Container(
                      width: 136.h,
                      margin: EdgeInsets.only(left: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              
                            },
                          ),
                          CustomIconButton(
                            height: 31.v,
                            width: 32.h,
                            padding: EdgeInsets.all(9.h),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgPlusWhiteA700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgRectangle39,
              height: 89.v,
              width: 60.h,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 48.h),
            ),
          ],
        ),
      ),
    ),
  );
}
}