import 'package:flutter/material.dart';

import '../constants/images_strings.dart';
import 'auth/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (builder) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 55, 99, 1),
      body: SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Image(
                width: 300,
                image: AssetImage(tSplashImage),
              ),

              // ignore: prefer_const_constructors
              SizedBox(
                height: 50,
              ),
              const SpinKitFadingCircle(
                color: Colors.white54,
                size: 50,
              )
            ]),
      ),
    );
  }
}
