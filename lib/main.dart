import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valery/firebase_options.dart';
import 'package:valery/pages/home_screen.dart';
import 'package:valery/pages/login.dart';
import 'package:valery/providers/cart_provider.dart';
import 'package:valery/providers/product_provider.dart';
import 'package:valery/providers/user_provider.dart';
import 'package:valery/push_notificaciones.dart';
import 'package:valery/servicios/auth_service.dart';
import 'package:valery/utils/util.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Hay un mensaje recibido");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificaciones.intt;
  //
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        /*
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        */
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: AuthService().firebaseAuth.authStateChanges(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              }
              return LogIn();
            }),
      ),
    );
  }
}
