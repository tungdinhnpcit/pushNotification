import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mba_ex01/model/pushnotification_model.dart';
import 'package:mba_ex01/notification_manager/notification_manager.dart';
import 'package:mba_ex01/widget/notification_badge.dart';
import '../firebase_options.dart';
import '../model/screen_argument_model.dart';
import 'ViewPage.dart';

GlobalKey<NavigatorState>? navigatorkey=GlobalKey<NavigatorState>();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // final RemoteMessage message;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _totalNotifications = 0;
  late final FirebaseMessaging _messaging;
  PushNotificationModel? _notificationInfo;

  void requestAndRegisterNotification() async {
    await Firebase.initializeApp();

    _messaging = FirebaseMessaging.instance;

    //On ios, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
      String? token = await _messaging.getToken();
      print("the token is:  " + token!);

      await FirebaseMessaging.instance.subscribeToTopic("NPCIT");

      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {

        print("onMessageOpenedApp: $message");
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);
        navigatorkey?.currentState?.pushNamed("viewNoti");

        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPage()));
        // Navigator.pushNamed(
        //   context,
        //   "/viewNoti",
        //   arguments: ViewNotificationArguments(
        //     "1",
        //     "2",
        //   ),
        // );
      });

      //if app is closed or terminiated
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) async {
        if (message != null) {
          await Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => ViewPage()));
          navigatorkey?.currentState?.pushNamed("viewNoti");
          print("getInitialMessage: $message");
        }
      });

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message != null) {
          PushNotificationModel notificationModel = PushNotificationModel(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          // debugPrint(message.data["page"]);

          // setState(() {
          //   _notificationInfo = notificationModel;
          //   _totalNotifications++;
          // });
          if (_notificationInfo != null) {
            if (defaultTargetPlatform == TargetPlatform.android) {
              // if this is available when Platform.isIOS, you'll receive the notification twice
              NotificationManager().NotificationShow(
                  _notificationInfo!.title!, _notificationInfo!.body!);
            } else if (defaultTargetPlatform == TargetPlatform.iOS) {}
          }
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    // numberGenerator = Provider.of<NumberGenerator>;
    // timerProvider = Provider.of<TimerProvider>;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // timerProvider.timer.cancel();
    // numberGenerator.ctrl.removeListener(() {});
    // animationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    // Add listeners to this class
    requestAndRegisterNotification();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //    if (this.widget.message != null) {
    //     Future.delayed(const Duration(milliseconds: 1000), () async {
    //       await Navigator.of(context).pushNamed("/");
    //     });
    //    }
    // });

    _totalNotifications = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        brightness: Brightness.dark,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('App for capturing Firebase push notification',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 20)),
        SizedBox(
          height: 16.0,
        ),
        // NotificationBage(totalNotifications: _totalNotifications),
        // SizedBox(
        //   height: 16.0,
        // ),
        // _notificationInfo != null
        //     ? Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Title: ${_notificationInfo!.title}',
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold, fontSize: 16.0),
        //     ),
        //     SizedBox(
        //       height: 8.0,
        //     ),
        //     Text('Body:${_notificationInfo!.body}',
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold, fontSize: 16.0)),
        //   ],
        // )
        //     : Container(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {

            // NotificationManager().NotificationShow("NON", "NON");
            navigatorkey?.currentState?.pushNamed("viewNoti");
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPage()));
          },
          child: Text('Elevated Button', style: TextStyle(fontSize: 28)),
        ),
      ]),
    );
  }
}
