import 'dart:io';

import 'package:electronic_final_project/auth/login.dart';
import 'package:electronic_final_project/controller/order.dart';
import 'package:electronic_final_project/controller/review.dart';
import 'package:electronic_final_project/controller/user.dart';
import 'package:electronic_final_project/model/user.dart';
import 'package:electronic_final_project/my_profile_screen/my_profile_my_orders_page/my_profile_my_reviews_page.dart';
import 'package:electronic_final_project/my_profile_screen/my_profile_my_order.dart';
import 'package:electronic_final_project/my_profile_screen/my_profile_page.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/theme/app_decoration.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:electronic_final_project/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_bottom_bar.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  BottomBarEnum _selectedBottomBarItem = BottomBarEnum.Profile;
   File? _selectedImage;
  String _profilePicture = '';

  int reviewCount = 0;
  int orderCount = 0;
  Future<void> fetchReviewCount() async {
    try {
      int count = await ReviewController().getCountReview();
      setState(() {
        reviewCount = count;
      });
    } catch (error) {}
  }

  Future<void> fetchOrderCount() async {
    try {
      int count = await OrderController().getCountOrder();
      setState(() {
        orderCount = count;
      });
    } catch (error) {}
  }



  Future<void> selectProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _profilePicture = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReviewCount();
    fetchOrderCount();
   
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: FutureBuilder<User>(
          future: UserController().getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: getVerticalSize(98),
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: getVerticalSize(96),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: ColorConstant.whiteA700,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: getPadding(left: 16),
                            child: Text(
                              "My Profile",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtSFUIDisplayHeavy34,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: getMargin(top: 40),
                    padding:
                        getPadding(left: 16, top: 7, right: 16, bottom: 50),
                    decoration: AppDecoration.white,
                    child: Row(
                      children: [
  GestureDetector(
  onTap: () {
    selectProfileImage();
  },


child:CircleAvatar(
  radius: 40,
  backgroundImage: _selectedImage != null
      ? Image.file(_selectedImage!).image
      : _profilePicture.isNotEmpty
          ? NetworkImage(_profilePicture)
          : null,
  child: _selectedImage == null && _profilePicture.isEmpty
      ? Icon(
          Icons.person,
          size: 75,
        )
      : null,
),

),

                        Padding(
                          padding: getPadding(left: 18, top: 8, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                user.username,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtSFUIDisplaySemibold18,
                              ),
                              Padding(
                                padding: getPadding(top: 3),
                                child: Text(
                                  user.email,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtSFUIDisplayRegular14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                             UserController.logout(context);
                          },
                          child: Icon(
                            Icons.logout,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Container(
                      decoration: AppDecoration.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Divider(
                            height: getVerticalSize(1),
                            thickness: getVerticalSize(1),
                            color: ColorConstant.black9000c,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyProfilePage(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: getPadding(
                                left: 16,
                                top: 18,
                                right: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Settings",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:
                                            AppStyle.txtSFUIDisplaySemibold15,
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 3,
                                        ),
                                        child: Text(
                                          "Notifications, password",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                              AppStyle.txtSFUIDisplayRegular11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomImageView(
                                    svgPath: ImageConstant.imgArrowrightGray600,
                                    height: getSize(24),
                                    width: getSize(24),
                                    margin: getMargin(
                                      top: 4,
                                      bottom: 7,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 15,
                            ),
                            child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.black9000c,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Container(
                      decoration: AppDecoration.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Divider(
                            height: getVerticalSize(1),
                            thickness: getVerticalSize(1),
                            color: ColorConstant.black9000c,
                          ),
                          Padding(
                            padding: getPadding(
                              top: 16,
                            ),
                            child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.black9000c,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Container(
                      decoration: AppDecoration.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Divider(
                            height: getVerticalSize(1),
                            thickness: getVerticalSize(1),
                            color: ColorConstant.black9000c,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyOrderScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: getPadding(
                                left: 16,
                                top: 18,
                                right: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "My Order",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:
                                            AppStyle.txtSFUIDisplaySemibold15,
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 3,
                                        ),
                                        child: Text(
                                          'Order Count: $orderCount',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                              AppStyle.txtSFUIDisplayRegular11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomImageView(
                                    svgPath: ImageConstant.imgArrowrightGray600,
                                    height: getSize(24),
                                    width: getSize(24),
                                    margin: getMargin(
                                      top: 4,
                                      bottom: 7,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 16,
                            ),
                            child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.black9000c,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Container(
                      decoration: AppDecoration.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Divider(
                            height: getVerticalSize(1),
                            thickness: getVerticalSize(1),
                            color: ColorConstant.black9000c,
                          ),
                          Padding(
                            padding: getPadding(
                              top: 15,
                            ),
                            child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.black9000c,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: Container(
                      decoration: AppDecoration.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Divider(
                            height: getVerticalSize(1),
                            thickness: getVerticalSize(1),
                            color: ColorConstant.black9000c,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyReviewScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: getPadding(
                                left: 16,
                                top: 18,
                                right: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "My reviews",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:
                                            AppStyle.txtSFUIDisplaySemibold15,
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 3,
                                        ),
                                        child: Text(
                                          'Review Count: $reviewCount',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:
                                              AppStyle.txtSFUIDisplayRegular11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomImageView(
                                    svgPath: ImageConstant.imgArrowrightGray600,
                                    height: getSize(24),
                                    width: getSize(24),
                                    margin: getMargin(
                                      top: 4,
                                      bottom: 7,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 15,
                            ),
                            child: Divider(
                              height: getVerticalSize(1),
                              thickness: getVerticalSize(1),
                              color: ColorConstant.black9000c,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        bottomNavigationBar: CustomBottomBar(
          onChanged: (item) {
            navigateToPage(context, item);
          },
          selectedBottomBarItem: BottomBarEnum.Profile,
        ),
      ),
    );
  }
}
