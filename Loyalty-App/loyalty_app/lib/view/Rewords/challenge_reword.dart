import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
    constraints: BoxConstraints(maxHeight: 900), 
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
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
  );
  }




Widget _buildPoints(BuildContext context) {
   
  return SizedBox(
    height: 200,
    width: double.maxFinite,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(right: 2),
            padding: EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
             
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: Text(
                    "Invite 10 New Friends",
                  style: CustomTextStyles.titleSmallBluegray90002,
                  ),
                ),
             
                  SizedBox(height: 23.v),
                
                Padding(
                  padding: EdgeInsets.only(right: 51.h),
                  child: Row(
                    children: [
                      SizedBox(width:30.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle34,
                        height: 54.v,
                        width: 88.h,
                      ),
                      SizedBox(width: 12),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text(
                            "Invite 10 new friends to join our app and get 100 points to use in amazing rewards!",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 23),
                Padding(
                  padding: EdgeInsets.only(left: 3, right: 13),
                  child: Row(
                    children: [
                      Container(
                        height: 22,
                        width: 150, 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.orange,
                              Colors.blue,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 11),
                      Text(
                        "6/10",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CustomElevatedButton(
            width: 160,
            text: "+100 Points",
            onPressed: () {
           
            },
          ),
        ),
      ],
    ),
  );
}

  }


Widget _buildChallengeCompleted(BuildContext context) {
   return SizedBox(
    height: 200,
    width: double.maxFinite,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(right: 2),
            padding: EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
             
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: Text(
                     "3 Daily Purchases",
                   style: CustomTextStyles.titleSmallBluegray90002,
                  ),
                ),
                SizedBox(height: 23.v),
                
                Padding(
                  padding: EdgeInsets.only(right: 51.h),
                  child: Row(
                    children: [
                      SizedBox(width:30.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle35,
                        height: 57.v,
                        width: 88.h,
                      ),
                      SizedBox(width: 12.h), 
                      
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text(
                     
                            "Visit our store daily and make purchase of at least 4 for 3 days straight!",
                          
                            style: TextStyle(
                              fontSize: 16,
                            ),
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
        Positioned(
          top: 0,
          right: 0,
          child: CustomElevatedButton(
          width: 160.h,
          text: "Challenge Completed!",
         
          alignment: Alignment.topRight,
        ),
        ),
      ],
    ),
  );
}


