// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:apphud/apphud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:re_fotos/feature/auth/splash_screen.dart';
import 'services/notification_service.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Apphud.start(apiKey: AppLinks.apphudKey);

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: AppLinks.firebaseApiKey,
      appId: AppLinks.firebaseAppId,
      messagingSenderId: AppLinks.firebaseMessagingSenderId,
      projectId: AppLinks.firebaseProjectId,
      storageBucket: AppLinks.firebaseStorageBucket,
    ),
  );

  runApp(MyApp());

  NotificationService notificationService = NotificationService();
  notificationService.activate();
  await Future.delayed(const Duration(seconds: 8));
  try {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
      inAppReview.openStoreListing(
        appStoreId: AppLinks.appStoreIdentifier,
      );
    }
  } catch (e) {
    throw Exception(e);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldKey,
      title: 'Re Fotos',
      theme: ThemeData(
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      home: SplashScreen(),
    );
  }
}

class AppLinks {
  static const String appStoreIdentifier = '1671925193';
  static const String apphudKey = 'app_bcbWL1h5yAXJYQDrSY3uKQf6Xq7AL8';
  static const String privacyPolicy = 'https://docs.google.com/document/d/1Y-WYTg-5d7yykd0ttWFp3A0qWLOcozik7IVRVMdX8wM/edit?usp=sharing';
  static const String termOfUse = 'https://docs.google.com/document/d/13psrnVU4DvX4S6YC21fmtD7ABG_Z57yDwTKNyhalqrE/edit?usp=sharing';
  static const String supportForm = 'https://sites.google.com/view/travlin/support-form';
  static const String firebaseApiKey = 'AIzaSyCrfbHG223e7q9XftDSMYMqSDGiSaYKJnY';
  static const String firebaseAppId = '1:9599165875:ios:c8055a0d008870cf3d97c6';
  static const String firebaseMessagingSenderId = '9599165875';
  static const String firebaseProjectId = 'refotos-8f272';
  static const String firebaseStorageBucket = 'refotos-8f272.appspot.com';
}
