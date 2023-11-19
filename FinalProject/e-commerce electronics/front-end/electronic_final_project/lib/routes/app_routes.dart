
import 'package:electronic_final_project/auth/login.dart';
import 'package:electronic_final_project/category/list_category.dart';
import 'package:electronic_final_project/favorites_modules_page/wishlist.dart';
import 'package:electronic_final_project/homepage/main_page.dart';
import 'package:electronic_final_project/my_profile_screen/my_profile_screen.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String signUpPageScreen = '/sign_up_page_screen';

  static const String loginPageScreen = '/login_page_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String mainPage = '/main_page';

  static const String mainPageContainerScreen = '/main_page_container_screen';

  static const String homepage = '/main_page';

  static const String categoriesScreen = '/categories_screen';

  static const String catalogPage = '/search';

  static const String catalogSortByScreen = '/catalog_sort_by_screen';

  static const String filtersScreen = '/filters_screen';

  static const String filtersListScreen = '/filters_list_screen';

  static const String productCardScreen = '/product_card_screen';

  static const String productCardSelectSizeScreen ='/product_card_select_size_screen';

  static const String favoritesPage = '/favorites_page';

  static const String myBagPage = '/my_cart_screen';

  static const String myBagEditScreen = '/my_bag_edit_screen';

  static const String myBagCheckoutScreen = '/my_bag_checkout_screen';

  static const String paymentCardsScreen = '/payment_cards_screen';

  static const String shippingAddressesScreen = '/shipping_addresses_screen';

  static const String addShippingAddressScreen = '/add_shipping_address_screen';

  static const String successScreen = '/success_screen';

  static const String myProfileScreen = '/my_profile_screen';

  static const String myProfileMyOrdersPage = '/my_profile_my_orders_page';

  static const String myProfileMyOrdersOrderDetailsScreen ='/my_profile_my_orders_order_details_screen';

  static const String myProfileSettingsScreen = '/my_profile_settings_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
 
  static Map<String, WidgetBuilder> routes = {
    //signUpPageScreen: (context) => SignUpPageScreen(),
    loginPageScreen: (context) => LoginPage(),
    //forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    //mainPageContainerScreen: (context) => MainPageContainerScreen(),
    homepage : (context) => HomePage(),
    categoriesScreen: (context) => CategoriesScreen(categories: [],),
   favoritesPage:(context)=>WishlistPage(),
    myProfileScreen: (context) => MyProfileScreen(),
    //catalogSortByScreen: (context) => CatalogSortByScreen(),
    //filtersScreen: (context) => FiltersScreen(),
   // filtersListScreen: (context) => FiltersListScreen(),
   // productCardScreen: (context) => ProductCardScreen(),
    //productCardSelectSizeScreen: (context) => ProductCardSelectSizeScreen(),
   // myBagEditScreen: (context) => MyBagEditScreen(),
    //myBagCheckoutScreen: (context) => MyBagCheckoutScreen(),
    //paymentCardsScreen: (context) => PaymentCardsScreen(),
    //shippingAddressesScreen: (context) => ShippingAddressesScreen(),
   // addShippingAddressScreen: (context) => AddShippingAddressScreen(),
   // successScreen: (context) => SuccessScreen(),
    
   // myProfileMyOrdersOrderDetailsScreen: (context) =>
      //  MyProfileMyOrdersOrderDetailsScreen(),
   /// myProfileSettingsScreen: (context) => MyProfileSettingsScreen(),
   // appNavigationScreen: (context) => AppNavigationScreen()
  };
}
