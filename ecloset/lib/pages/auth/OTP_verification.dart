import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/email_auth_controller.dart';
import 'forgetPassword.dart';
import 'login_page.dart';

class Verification extends StatelessWidget {
  final String email;
  Verification({Key? key, required this.email}) : super(key: key);

  // final _loginscreen = GlobalKey<FormState>();
  // final emailController = TextEditingController();
  final otpControler = TextEditingController();
  // bool passToogle = true;
  EmailAuthorityController emailAuthorityController =
      Get.put(EmailAuthorityController());

  @override
  Widget build(BuildContext context) {
    _textFieldOTP({required bool first, last}) {
      return Container(
        height: 65,
        child: AspectRatio(
          aspectRatio: 0.8,
          child: TextField(
            controller: otpControler,
            onTap: () => FocusScope.of(context).unfocus(),
            autofocus: false,
            onChanged: ((value) => {
                  if (value.length == 1 && last == false)
                    {FocusScope.of(context)}
                  else if (value.length == 0 && first == false)
                    {FocusScope.of(context).previousFocus()}
                }),
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                )),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 235, 183, 0.8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          // key: _forgetpassword,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                child: Column(children: [
                  BackButton(
                      color: const Color.fromRGBO(36, 55, 99, 1),
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (builder) => const ForgetPassword()))),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(86, 0, 0, 0),
                child: Text(
                  "OTP verification",
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
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(first: true, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: true),
                    ],
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 10, 31, 0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        emailAuthorityController.validateOTP(
                            email, otpControler.text.trim());
                        // (emailController.text.trim());
                        // if (_forgetpassword.currentState!.validate()) {
                        //   emailController.clear();
                        //   Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (builder) => const Verification()));
                        // }
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(36, 55, 99, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Verify",
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
                padding: const EdgeInsets.fromLTRB(140, 20, 0, 0),
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
    );
  }
}
