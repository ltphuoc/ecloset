import 'package:ecloset/pages/home_page.dart';
import 'package:ecloset/values/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecloset',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
