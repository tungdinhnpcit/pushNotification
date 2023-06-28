import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager{
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async{
    AndroidInitializationSettings initializationAndroid = const AndroidInitializationSettings('flutter_logo');
    DarwinInitializationSettings initializationIos= DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload){}
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android:initializationAndroid,
      iOS: initializationIos
    );

    await notificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (detail){}
    );
  }

  Future<void> NotificationShow(String title, String body) async{
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'channelId', 'chanel_title',
    priority:  Priority.high,
    importance: Importance.max,
    icon:'flutter_logo',
    channelShowBadge: true,
    largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));

    NotificationDetails notificationDetails=NotificationDetails(android: androidNotificationDetails);

    await notificationsPlugin.show(0, title, body, notificationDetails);
  }
}