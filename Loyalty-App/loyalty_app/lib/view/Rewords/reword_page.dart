import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/view/Rewords/challenge_reword.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_icon_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:percent_indicator/linear_percent_indicator.dart';

class RewordPage extends StatefulWidget {
  RewordPage({Key? key}) : super(key: key);

  @override
  _RewordPageState createState() => _RewordPageState();
}

class _RewordPageState extends State<RewordPage> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

 @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildMegaphone(context),
              SizedBox(height: 61.v),
              SizedBox(height: 5.v),
             _buildTabContent(),
            ],
          ),
        ),
      ),
    ),
  );
}



Widget _buildMegaphone(BuildContext context) {
  return Container(
    height: 278.v,
    width: double.maxFinite,
    color: Colors.black.withOpacity(0.5),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgImg383x388,
          height: 278.v,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 50,
            color: Colors.black.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabBarItem("Available Rewards", 0),
                _buildTabBarItem("Challenges", 1),
                _buildTabBarItem("Transactions", 2),
              ],
            ),
          ),
        ),
       
      ],
    ),
  );
}




  Widget _buildTabBarItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPageIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentPageIndex == index ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  Widget _buildTabContent() {
    switch (_currentPageIndex) {
      case 0:
        return _buildRewardsPageContent();
      case 1:
        return _buildChallengesPage(context);
      case 2:
        return _buildTransactionsPage();
      default:
        return Container(); 
    }
  }




  Widget _buildTransactionsPage() {
   
    return Container();
  }
  
 

  int userPoints = 60;
  Widget _buildRectangleTwo(BuildContext context) {
    double bronzeProgress = (userPoints <= 500) ? userPoints / 500 : 1.0;
    double silverProgress = (userPoints > 500 && userPoints <= 1000)
        ? (userPoints - 500) / 500
        : (userPoints > 1000)
            ? 1.0
            : 0.0;
    double goldProgress = (userPoints > 1000 && userPoints <= 1500)
        ? (userPoints - 1000) / 500
        : (userPoints > 1500)
            ? 1.0
            : 0.0;

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
          Positioned(
            bottom: 22,
            left: 50,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgEllipse161x57,
                        height: 61,
                        width: 57,
                        radius: BorderRadius.circular(30),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          lineHeight: 8.0,
                          percent: bronzeProgress,
                          backgroundColor: Colors.grey,
                          progressColor: appTheme.deepOrangeA700E5,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgEllipse261x57,
                        height: 61,
                        width: 57,
                        radius: BorderRadius.circular(30),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          lineHeight: 8.0,
                          percent: silverProgress,
                          backgroundColor: Colors.grey,
                          progressColor: appTheme.deepOrangeA700E5,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgEllipse361x57,
                        height: 61,
                        width: 57,
                        radius: BorderRadius.circular(30),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Come back everyday and collect 5 free points",
                    style: CustomTextStyles.titleSmallBluegray90002,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 13,
            left: 25,
            right: 29,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    "Current Points",
                    style: CustomTextStyles.titleMediumPoppinsGray900,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CustomElevatedButton(
              height: 46,
              width: 179,
              text: "Come back in 22:45:23",
              buttonTextStyle: CustomTextStyles.labelLargeInterGray100,
              alignment: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildRewardsPageContent() {
  return Container(
    constraints: BoxConstraints(maxHeight: 900), // Add a maxHeight constraint
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRectangleTwo(context),
        SizedBox(height: 61.v),
        Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgClose,
              height: 31.v,
              width: 39.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.h),
              child: Text(
                "Hottest Rewards",
                style: CustomTextStyles.titleMediumPoppinsGray900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10), // Add some spacing
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 19.h, right: 28.h),
            child: _buildSoftDrinkGridView(context),
          ),
        ),
      ],
    ),
  );
}


Widget _buildSoftDrinkGridView(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 12.0,
    crossAxisSpacing: 25.0,
    childAspectRatio: 166.h / 190.v,
    children: [
      _buildProduct02(
        context,
        softDrink: "SoftDrink",
        cafenioRestaurant: "Rose garden",
        price: "40",
      ),
      _buildProduct02(
        context,
        softDrink: "SoftDrink",
        cafenioRestaurant: "Cafenio Restaurant",
        price: "60",
      ),
    ],
  );
}


Widget _buildProduct02(
  BuildContext context, {
  required String softDrink,
  required String cafenioRestaurant,
  required String price,
}) {
  return SizedBox(
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
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6.v,
                            bottom: 4.v,
                          ),
                          child: Text(
                            price,
                            style: CustomTextStyles.titleMediumSenBluegray90001
                                .copyWith(
                              color: appTheme.blueGray90001,
                            ),
                          ),
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
  );
}




Widget _buildChallengesPage(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      constraints: BoxConstraints(maxHeight: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          _buildPoints(context),
          SizedBox(height: 61.v),
          SizedBox(height: 10), // Add some spacing
          Padding(
            padding: EdgeInsets.only(left: 19.h, right: 28.h),
            child: _buildChallengeCompleted(context),
          ),
        ],
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
            padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 25.v),
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
                      SizedBox(width: 12.h), // Add a SizedBox instead of Flexible
                      Expanded(
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
         
          alignment: Alignment.topRight,
        ),
      ],
    ),
  );
}
}