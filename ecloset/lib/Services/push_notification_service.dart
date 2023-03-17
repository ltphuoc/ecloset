import 'package:ecloset/Widgets/custom_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationService {
  static PushNotificationService? _instance;

  static PushNotificationService getInstance() {
    _instance ??= PushNotificationService();
    return _instance as PushNotificationService;
  }

  static void destroyInstance() {
    _instance = null;
  }

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future init() async {
    if ((defaultTargetPlatform == TargetPlatform.iOS)) {
      await _fcm.requestPermission();
      _fcm.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
    }

    // RemoteMessage? message =
    //     await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((event) async {
      // hideSnackbar();
      RemoteNotification? notification = event.notification;
      CustomDialogBox(
        title: notification!.title ?? "",
        descriptions: notification.body ?? "",
      );
      // await showStatusDialog(
      //     "assets/images/option.png", notification.title, notification.body);
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   var screen = event.data['screen'];
    //   if (screen == RoutHandler.PRODUCT_FILTER_LIST) {
    //     Get.toNamed(
    //       RoutHandler.PRODUCT_FILTER_LIST,
    //       arguments: event.data,
    //     );
    //   }
    // });
  }

  Future<String> getFcmToken() async {
    String token = _fcm.getToken() as String;
    return token;
  }
}
