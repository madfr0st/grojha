import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:grojha/screens/cart/cart_screen.dart';
import 'package:grojha/screens/complete_profile/complete_profile_screen.dart';
import 'package:grojha/screens/help_center/help_center_screen.dart';
import 'package:grojha/screens/home/components/categories.dart';
import 'package:grojha/screens/home/home_screen.dart';
import 'package:grojha/screens/login_screen/login_screen.dart';
import 'package:grojha/screens/new_update/new_update_screen.dart';
import 'package:grojha/screens/notification/notification_screen.dart';
import 'package:grojha/screens/orders/orders_screen.dart';
import 'package:grojha/screens/otp_screen/otp_screen.dart';
import 'package:grojha/screens/place_order/place_order_screen.dart';
import 'package:grojha/screens/profile/profile_screen.dart';
import 'package:grojha/screens/single_selected_product_category/SingleSelectedProductCategory.dart';
import 'package:grojha/screens/single_selected_shop_category/single_selected_shop_category.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';
import 'package:grojha/screens/splash_screen/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName:(context)=> SplashScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName:(context) => OtpScreen(),
  LoginScreen.routeName:(context)=> LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SingleShop.routeName: (context) => SingleShop(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  PlaceOrderScreen.routeName: (context) => PlaceOrderScreen(),
  SingleSelectedShopCategory.routeName: (context) =>
      SingleSelectedShopCategory(),
  SingleSelectedProductCategory.routeName: (context) =>
      SingleSelectedProductCategory(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  HelpCenterScreen.routeName: (context) => HelpCenterScreen(),
  NewUpdateScreen.routeName:(context) => NewUpdateScreen(),
};
