import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ads_web/Admin/Myapp.dart';
import 'package:super_ads_web/aboutUs.dart';
import 'package:super_ads_web/contact.dart';
import 'package:super_ads_web/home.dart';
import 'package:super_ads_web/policies.dart';
import 'package:super_ads_web/presskit.dart';
import 'package:super_ads_web/result.dart';
import 'package:super_ads_web/signUp.dart';
import 'package:url_strategy/url_strategy.dart';

int? hideOnboardingScreen;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        // apiKey: "AIzaSyA_68RTO8v1aaZm3L1uScwhFjwcAeLKum0",
        // authDomain: "medeasy-829d9.firebaseapp.com",
        // projectId: "medeasy-829d9",
        // storageBucket: "medeasy-829d9.appspot.com",
        // messagingSenderId: "529282502849",
        // appId: "1:529282502849:web:741140711937bfa2350440",
        // measurementId: "G-PTC3NTBPFN",
        apiKey: "AIzaSyDiuV_oslJM_5fGZ--QHCXYarHx6P9pC9M",
        authDomain: "beyond--time.firebaseapp.com",
        projectId: "beyond--time",
        storageBucket: "beyond--time.appspot.com",
        messagingSenderId: "225861500934",
        appId: "1:225861500934:web:d92cecd85438f147764387",
        measurementId: "G-XZKKRPN5JB",
      ),
    );
    setPathUrlStrategy();
  } else {
    await Firebase.initializeApp();
    HttpOverrides.global = MyHttpOverrides();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    hideOnboardingScreen = sharedPreferences.getInt('onBoardStatus');
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //
          const MyApp(),
      // Home()
      // CreateAccount(phone: '1234567890')
      // Contact(),
      // Policies()
      // pressKit()
      // AboutUs()
      // Result(search: ''),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
