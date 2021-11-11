import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grojha/locator.dart';
import 'package:grojha/routes.dart';
import 'package:grojha/screens/home/home_screen.dart';
import 'package:grojha/screens/new_update/new_update_screen.dart';
import 'package:grojha/screens/order_details/order_details_variables.dart';
import 'package:grojha/screens/splash_screen/splash_screen.dart';
import 'package:grojha/size_config.dart';
import 'package:grojha/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'Objects/current_user.dart';
import 'components/loading.dart';
import 'constants.dart';
import 'message.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        Provider<CurrentUser>(create: (context)=>CurrentUser()),
        ChangeNotifierProvider<OrderDetailsVariables>(
            create: (context) => OrderDetailsVariables()),
        //ChangeNotifierProvider<>(create: (context) => SomeOtherClass()),
      ],
      child: App(),
    ),
  );
}

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.pushNamed(context, '/message',
            arguments: MessageArguments(message, true));
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
                icon: 'applogo',
                color: kPrimaryColor,
                enableVibration: true,
                playSound: true,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("snapshot error");
          return CircularProgressIndicator(
            color: kPrimaryColor,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("connection is done");
          //databaseReference.push().set({'name': "check", 'comment': 'A good season'});

          FirebaseMessaging.instance.getToken().then((value) {
            print(value);
          });
          print("---------------------------");

          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        print("loading");
        return CircularProgressIndicator(
          color: kPrimaryColor,
        );
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User user = FirebaseAuth.instance.currentUser;
  String string = SplashScreen.routeName;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      print('User is currently signed in :)');
      string = HomeScreen.routeName;
    } else {
      print('User is currently null :(');
    }

    return FutureBuilder(
        future: _logic(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            try {
              if (snapshot.data) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Grojha',
                  theme: theme(),
                  // home: SplashScreen(),
                  // We use routeName so that we dont need to remember the name
                  initialRoute: string,
                  routes: routes,
                  builder: (context, child) {
                    SizeConfig().init(context);
                    return MediaQuery(
                      child: child,
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    );
                  },
                );
              } else {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Grojha',
                  theme: theme(),
                  // home: SplashScreen(),
                  // We use routeName so that we dont need to remember the name
                  initialRoute: NewUpdateScreen.routeName,
                  routes: routes,
                  builder: (context, child) {
                    SizeConfig().init(context);
                    return MediaQuery(
                      child: child,
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    );
                  },
                );
              }
            } catch (e) {
              print(e);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Grojha',
                theme: theme(),
                // home: SplashScreen(),
                // We use routeName so that we dont need to remember the name
                initialRoute: NewUpdateScreen.routeName,
                routes: routes,
                builder: (context, child) {
                  SizeConfig().init(context);
                  return MediaQuery(
                    child: child,
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  );
                },
              );
            }
          }
          return Center(
            child: Loading.loadingGrojha(),
          );
        });
  }

  Future<bool> _logic() async {
    await FirebaseDatabase.instance.setPersistenceEnabled(true);
    await FirebaseDatabase.instance.reference().keepSynced(true);
    await FirebaseDatabase.instance.setPersistenceCacheSizeBytes(100000000);
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("grojhaAppVersion");

    return await databaseReference.once().then((value) {
      print(value.value);
      if (value.value <= SizeConfig.appVersion) {
        return true;
      }
      return false;
    });
  }
}
