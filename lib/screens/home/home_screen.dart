import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grojha/Objects/app_user.dart';
import 'package:grojha/business_logic/FCM.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/business_logic/get_notifications.dart';
import 'package:grojha/components/coustom_bottom_nav_bar.dart';
import 'package:grojha/enums.dart';
import 'package:grojha/screens/home/components/home_header.dart';
import 'package:grojha/screens/orders/orders_screen.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';
import 'package:grojha/services/push_notification_service.dart';
import 'package:grojha/size_config.dart';

import '../../constants.dart';
import '../../locator.dart';
import 'components/body.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static bool onceTapOneNotification = false;
  var flutterLocalNotificationsPlugin = locator<PushNotificationService>().flutterLocalNotificationsPlugin;
  var channel = locator<PushNotificationService>().channel;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    CartItemCount.init();
    PlaceOrderVariables();
    FCM.init();
    GetNotifications();
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null && !onceTapOneNotification) {
        onceTapOneNotification = true;
        Navigator.pop(context);
        Navigator.pushNamed(context,OrdersScreen.routeName);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/notification_logo',
                color: kPrimaryColor,
                enableVibration: true,
                playSound: true,
                sound: RawResourceAndroidNotificationSound('alert'),
                importance: Importance.max,
                priority: Priority.max,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

      // int _yourId = int.tryParse(message.data["id"]) ?? 0;
      Navigator.pushNamed(context,OrdersScreen.routeName);
    });
  }
}
