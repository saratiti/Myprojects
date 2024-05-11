import 'package:flutter/material.dart';
import 'package:loyality_cashier/core/app_export.dart';
import 'package:loyality_cashier/core/routes/app_routes.dart';
import 'package:loyality_cashier/view/home_page/home_page.dart';
import 'package:loyality_cashier/widgets/app_bar/custom_bottom_bar.dart';

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
                    transitionDuration: const Duration(seconds: 0))),
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
        return const DefaultWidget();
    }
  }
}

