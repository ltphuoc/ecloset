import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/email_auth_controller.dart';
import 'OTP_verification.dart';
import 'login_page.dart';

class ForgetPassword extends StatefulWidget {
  // final String accesstoken;
  // const ForgetPassword({super.key});
  const ForgetPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _forgetpassword = GlobalKey<FormState>();
  final emailController = TextEditingController();

  EmailAuthorityController emailAuthorityController =
      Get.put(EmailAuthorityController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 235, 183, 0.8),
        body: SingleChildScrollView(
          child: Form(
            key: _forgetpassword,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
                  child: Column(children: [
                    BackButton(
                        color: const Color.fromRGBO(36, 55, 99, 1),
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (builder) => const LoginScreen()))),
                  ]),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(86, 0, 0, 0),
                  child: Text(
                    "Forget Password",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(36, 55, 99, 1)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 14, 0, 0),
                  child: Text(
                    "We will send you 6 once-time digit to this e-mail",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black45,
                        letterSpacing: 0.3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 29, 31, 0),
                  child: TextFormField(
                    onTap: () => {
                      FocusScope.of(context).unfocus(),
                      emailAuthorityController
                          .sendOTP(emailController.text.trim())
                    },
                    scrollPhysics: const AlwaysScrollableScrollPhysics(),
                    controller: emailController,
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Enter email";
                      } else if (!emailValid) {
                        return "Please Enter Valid Email";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "name@example.com",
                      hintStyle:
                          TextStyle(color: Color(0xFF83859C), fontSize: 14),
                      labelText: "Email",
                      labelStyle:
                          TextStyle(color: Color(0xFF83859C), fontSize: 16),
                      border: OutlineInputBorder(
                          gapPadding: 1,
                          borderSide: BorderSide(
                              color: Color.fromRGBO(199, 200, 210, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 29, 31, 0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          emailAuthorityController
                              .sendOTP(emailController.text.trim());
                          if (_forgetpassword.currentState!.validate()) {
                            emailController.clear();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (builder) => Verification(
                                          email: emailController.text,
                                        )));
                          }
                        },
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(36, 55, 99, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Get OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(140, 100, 0, 0),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (builder) => const LoginScreen()));
                          },
                          child: const Text("Back to Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(84, 85, 99, 1))))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
