import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mba_ex01/model/pushnotification_model.dart';
import 'package:mba_ex01/notification_manager/firebase_services.dart';
import 'package:mba_ex01/notification_manager/notification_manager.dart';
import 'package:mba_ex01/page/ViewPage.dart';
import 'package:mba_ex01/page/homePage.dart';
import 'package:mba_ex01/page/viewNotification.dart';
import 'package:mba_ex01/widget/notification_badge.dart';
import '../firebase_options.dart';
import 'Utilities/app_navigatorservice.dart';
import 'Utilities/locator.dart';
import 'Utilities/route_generator.dart';
import 'model/screen_argument_model.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print(message.notification?.title);
  print(message.data.toString());
}

Future<void> _firebaseMessagingBackgroundHandle(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message:${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandle);

  // await FirebaseService.initializeFirebase();
  final RemoteMessage? _message = await FirebaseService.firebaseMessaging
      .getInitialMessage();

  FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message) async {
    navigatorkey?.currentState?.pushNamed("viewNoti");
    if (message != null) {
      navigatorkey?.currentState?.pushNamed("viewNoti");
      // Navigator.pushNamed(
      //   context,
      //   "/viewNoti",
      //   arguments: ViewNotificationArguments(
      //     "1",
      //     "2",
      //   ),
      // );
    }
  });

  NotificationManager().initNotification();
  FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
  });

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp(
    // message: _message,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Nofitication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorkey,
      routes: {
        "home": (BuildContext ctx) => MyHomePage(title: "TRANG CHỦ"),
        "viewNoti": (BuildContext ctx) => ViewPage(),
      },
      home: MyHomePage(title: "HOME PAGE",)
    );
  }
}