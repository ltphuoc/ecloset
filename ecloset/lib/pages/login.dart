import 'dart:math';

import 'package:ecloset/Utils/routes_name.dart';
import 'package:ecloset/ViewModel/login_viewModel.dart';
import 'package:ecloset/Widgets/button_global.dart';
import 'package:ecloset/Widgets/text_form_field.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: LoginViewModel(),
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                color: Colors.grey.shade100,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                // padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/logo.png',
                        width: 250,
                        height: 150,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Text(
                        'Login to your account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormGlobal(
                        controller: emailController,
                        text: 'Email',
                        obscure: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormGlobal(
                        controller: passwordController,
                        text: 'Password',
                        obscure: false,
                        textInputType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: ButtonGlobal(
                        text: 'Sign In',
                        onPressed: () {
                          log(1);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SocialLogin(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.center,
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteName.signUp);
                  },
                  child: const Text(
                    ' Sign Up',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget SocialLogin() {
    return ScopedModel(
      model: LoginViewModel(),
      child: ScopedModelDescendant<LoginViewModel>(
        builder: (context, child, model) {
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text(
                  '-Or sign in with-',
                  style: TextStyle(
                      color: AppColors.textGrey, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ]),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/icons/fb_logo.png',
                          height: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          model.signInWithGoogle();
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                ),
                              ]),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/icons/gg_logo.jpeg',
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
