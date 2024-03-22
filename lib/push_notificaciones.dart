import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificaciones {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  // requerimiento de permisos
  static Future intt() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // token del dispositivo
    final token = await _firebaseMessaging.getToken();
    print("token del dispositivo: $token");
  }
}
