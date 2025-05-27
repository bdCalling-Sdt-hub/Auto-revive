import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import '../core/app_constants/app_constants.dart';
import '../helpers/prefs_helper.dart';



class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Singleton pattern
  FirebaseNotificationService._privateConstructor();
  static final FirebaseNotificationService instance = FirebaseNotificationService._privateConstructor();



  /// **Initialize Firebase Notifications**
  static Future<void> initialize() async {
    // Request notification permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("🚫 Notification permission denied");
      return;
    }

    // Initialize local notifications
    const AndroidInitializationSettings androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initSettings = InitializationSettings(android: androidInitSettings, iOS: iosSettings);
    await _localNotifications.initialize(initSettings);

    // Handle FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
      debugPrint("📩 App opened from foreground message: ${message.data}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("📩 App opened from notification: ${message.data}");
    });
  }

  /// **Handle foreground FCM messages and show local notification**
  // static Future<void> _handleForegroundMessage(RemoteMessage message) async {
  //   debugPrint("📩 Received foreground notification: ${message.notification?.title}");
  //
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //
  //   if (notification != null && android != null) {
  //     _localNotifications.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'reservation_channel',
  //           'Gestion App',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           playSound: true,
  //           icon: '@mipmap/ic_launcher',
  //         ),
  //       ),
  //     );
  //   }
  // }


  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint("📩 Received foreground notification: ${message.notification?.title}");
    debugPrint("🔍 Full Message: ${message.toMap()}");

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'reservation_channel',
            'Gestion App',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            icon: '@mipmap/ic_launcher', // Make sure this exists
          ),
        ),
      );
    } else {
      debugPrint("⚠️ Notification or Android part is null. Possibly a data-only message.");
    }
  }


  /// **Retrieve FCM Token**
  static Future<String?> getFCMToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();

    if(fcmToken!.isNotEmpty){
      return fcmToken;
    }else{
      return null;
    }

  }



  /// **Print FCM Token & Store it in Preferences**
  static Future<void> printFCMToken() async {
    String token = await PrefsHelper.getString(AppConstants.fcmToken);
    if (token.isNotEmpty) {
      debugPrint("🔑 FCM Token (Stored): $token");
    } else {
      token = await getFCMToken() ?? '';
      PrefsHelper.setString(AppConstants.fcmToken, token);
      debugPrint("🔑 FCM Token (New): $token");
    }
  }


}