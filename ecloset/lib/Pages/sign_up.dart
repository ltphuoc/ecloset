import 'package:ecloset/Constant/app_colors.dart';
import 'package:ecloset/ViewModel/signUp_viewModel.dart';
import 'package:ecloset/Widgets/button_global.dart';
import 'package:ecloset/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: SignUpViewModel(),
        child: ScopedModelDescendant<SignUpViewModel>(
          builder: (context, child, model) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    // padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 35, top: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () async {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_back_ios,
                                      size: 20, color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 35),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 90,
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(left: 15, right: 15),
                        //   child: Text(
                        //     'Login to your account',
                        //     style: TextStyle(
                        //       // color: Colors.white,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            'Name',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormGlobal(
                            controller: nameController,
                            text: 'Example',
                            obscure: false,
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormGlobal(
                            controller: emailController,
                            text: 'name@fpt.edu.vn',
                            obscure: false,
                            textInputType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            'Phone',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormGlobal(
                            controller: phoneController,
                            text: 'sdt',
                            obscure: false,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            'Password',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormGlobal(
                            controller: passwordController,
                            text: 'min 8 character',
                            obscure: false,
                            textInputType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormGlobal(
                            controller: passwordController,
                            text: 'min 8 character',
                            obscure: false,
                            textInputType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: ButtonGlobal(
                            text: 'Sign Up',
                            onPressed: () {
                              print('Sign Up');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.center,
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
