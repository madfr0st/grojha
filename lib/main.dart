import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grojha/locator.dart';
import 'package:grojha/routes.dart';
import 'package:grojha/screens/home/home_screen.dart';
import 'package:grojha/screens/new_update/new_update_screen.dart';
import 'package:grojha/screens/order_details/order_details_variables.dart';
import 'package:grojha/screens/splash_screen/splash_screen.dart';
import 'package:grojha/services/push_notification_service.dart';
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


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  await locator<PushNotificationService>().init();

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
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("snapshot error");
          return Loading.loadingMainGrojha();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("connection is done");
          //databaseReference.push().set({'name': "check", 'comment': 'A good season'});
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        print("loading");
        return Loading.loadingMainGrojha();
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
  Widget home = SplashScreen();

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      print('User is currently signed in :)');
      home = HomeScreen();
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
                  home: home,
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
          return Loading.loadingMainGrojha();
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
