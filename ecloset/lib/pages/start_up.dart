import 'package:ecloset/ViewModel/startup_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StartUpViewModel>(
      model: StartUpViewModel(),
      child: ScopedModelDescendant<StartUpViewModel>(
          builder: (context, child, model) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/background_blue.jpg"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/logo.png",
                    // fit: BoxFit.fill,
                    width: 250,
                    height: 150,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final String title;
  const LoadingScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: 250.0,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LoadingBean(),
              const SizedBox(height: 16),
              Text(
                title,
                style: Get.theme.textTheme.displayLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
