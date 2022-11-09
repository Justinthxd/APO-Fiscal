import 'package:apo_delivery/pages/AccountPage.dart';
import 'package:apo_delivery/pages/LoginPage.dart';
import 'package:apo_delivery/pages/MapPage.dart';
import 'package:apo_delivery/pages/OrderPage.dart';
import 'package:apo_delivery/pages/SplashPage.dart';
import 'package:apo_delivery/provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {}
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APO Delivery',
        initialRoute: '/Splash',
        routes: {
          '/Splash': (context) => Splash(),
          '/': (context) => const HomePage(),
          '/Login': (context) => const LoginPage(),
          '/Account': (context) => const AccountPage(),
          '/Map': (context) => const Map(),
          '/Order': (context) => Order(),
        },
      ),
    );
  }
}
