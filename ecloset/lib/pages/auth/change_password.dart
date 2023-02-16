import 'package:flutter/material.dart';

import 'forgetPassword.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _SignUpState();
}

class _SignUpState extends State<ChangePassword> {
  final _changepasswordscreen = GlobalKey<FormState>();
  final passwordControler = TextEditingController();
  final passConfirmController = TextEditingController();

  bool passToogle = true;
  bool confirmPassword = true;
  bool firstValue = false;
  bool secondValue = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 235, 183, 0.8),
        body: SingleChildScrollView(
          child: Form(
            key: _changepasswordscreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                  child: Column(children: [
                    BackButton(
                        color: const Color.fromRGBO(36, 55, 99, 1),
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (builder) => const ForgetPassword()))),
                  ]),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(31, 0, 0, 0),
                  child: Text(
                    "Update your new password",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(36, 55, 99, 1)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(35, 18, 31, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          onTap: () => FocusScope.of(context).unfocus(),
                          obscureText: passToogle,
                          controller: passwordControler,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else if (passwordControler.text.length < 8) {
                              return "Password should not be less than 8 characters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "min. 8 characters",
                              hintStyle: const TextStyle(
                                  color: Color(0xFF83859C), fontSize: 14),
                              labelText: "Password",
                              labelStyle: const TextStyle(
                                  color: Color(0xFF83859C), fontSize: 16),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 210, 1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToogle = !passToogle;
                                  });
                                },
                                child: Icon(
                                  passToogle
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 18,
                                ),
                              )),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(35, 18, 31, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          onTap: () => FocusScope.of(context).unfocus(),
                          obscureText: confirmPassword,
                          controller: passConfirmController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please re-enter the password to confirm";
                            } else if (value != passwordControler.text) {
                              return "Password should match with the password you provide";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Color(0xFF83859C), fontSize: 14),
                              labelText: "Confirm Password",
                              labelStyle: const TextStyle(
                                  color: Color(0xFF83859C), fontSize: 16),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(199, 200, 210, 1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    confirmPassword = !confirmPassword;
                                  });
                                },
                                child: Icon(
                                  confirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 18,
                                ),
                              )),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
