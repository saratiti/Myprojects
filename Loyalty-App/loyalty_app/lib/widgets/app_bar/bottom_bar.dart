import 'package:flutter/material.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/core/utils/theme/theme_helper.dart';
import 'package:loyalty_app/view/home_page/home_page.dart';
import 'package:loyalty_app/widgets/app_bar/custom_bottom_bar.dart';

// ignore: must_be_immutable
class Bottombar extends StatelessWidget {
  Bottombar({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray100,
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.homeScreen,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreen;
      case BottomBarEnum.Scanpay:
        return "/";
      case BottomBarEnum.Reword:
        return AppRoutes.rewordScreen;
      case BottomBarEnum.Order:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeScreen:
        return HomePage();
      default:
        return DefaultWidget();
    }
  }
}

