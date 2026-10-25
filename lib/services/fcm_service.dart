import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _requestPermission();
    await _getToken();
    await _handleForGroundNotification();
  }

  // permission

  static Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      announcement: true,
      carPlay: false,
      sound: true,
      criticalAlert: false,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  // Token

  static Future<void> _getToken() async {
    final token = await _messaging.getToken();
    print("token is :  ${token}");
  }

  //  Back and terminate

  // for ground

  static Future<void> _handleForGroundNotification() async {
    final channel = AndroidNotificationChannel(
      "high_importance_channel",
      "high importance channel",
      description: "This channel for importance notification",
      importance: .max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
    >()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(id: notification.hashCode,
            body: notification.body,
            title: notification.title,
            notificationDetails: NotificationDetails(android:
            AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,icon: "@mipmap/ic_launcher")
            )
        );
      }
    });
  }
}
