import 'dart:io';

import 'package:ecloset/constants/app_colors.dart';
import 'package:ecloset/firebase_options.dart';
import 'package:ecloset/pages/splash_page.dart';
import 'package:ecloset/utils/routes.dart';
import 'package:ecloset/utils/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eCloset',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      // initialRoute: RouteName.splashPage,
      initialRoute: RouteName.app,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
