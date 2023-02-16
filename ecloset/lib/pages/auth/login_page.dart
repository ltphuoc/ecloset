import 'package:ecloset/pages/auth/sign_up.dart';
import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import '../../constants/text_strings.dart';
import '../../widgets/squart_title.dart';
import 'forgetPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginscreen = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordControler = TextEditingController();
  final googleLoginController = GlobalKey<FormState>();
  final faceBookLoginController = GlobalKey<FormState>();

  bool passToogle = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 235, 183, 0.8),
          body: SingleChildScrollView(
            child: Form(
              key: _loginscreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(35, 40, 0, 0),
                    child: Text(
                      tLoginTitle,
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(36, 55, 99, 1)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(35, 14, 0, 0),
                    child: Text(
                      tLoginSubTitle,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45,
                          letterSpacing: 0.1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 20, 31, 0),
                    child: TextFormField(
                      onTap: () => FocusScope.of(context).unfocus(),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(35, 15, 31, 0),
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
                                        color:
                                            Color.fromRGBO(199, 200, 210, 1)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passToogle = !passToogle;
                                    });
                                  },
                                  child: Icon(
                                      textDirection: TextDirection.ltr,
                                      size: 18,
                                      passToogle
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                )),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 20, 31, 0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_loginscreen.currentState!.validate()) {
                              loginUsers();
                              emailController.clear();
                              passwordControler.clear();
                            }
                          },
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(36, 55, 99, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                tLoginTitle,
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
                    padding: const EdgeInsets.fromLTRB(42, 0, 20, 0),
                    child: Row(
                      children: <Widget>[OrDivider()],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_loginscreen.currentState!.validate()) {
                            // loginUsers();
                            emailController.clear();
                            passwordControler.clear();
                          }
                        },
                        child: Row(
                          children: [
                            // google button
                            MyCustomWidget(
                              key: googleLoginController,
                              imagePath: 'assets/images/icons8-google-48.png',
                              height: 50,
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            //facebook button
                            MyCustomWidget(
                              key: faceBookLoginController,
                              imagePath: 'assets/images/icons8-facebook-48.png',
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(140, 20, 0, 0),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          const ForgetPassword()));
                            },
                            child: const Text("Forgot Password",
                                style: TextStyle(
                                    color: Color.fromRGBO(36, 55, 99, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 10, 0, 0),
                    child: Row(
                      children: [
                        const Text("Don’t have an account?",
                            style: TextStyle(
                                color: Color.fromRGBO(84, 85, 99, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (builder) => const SignUp()));
                            },
                            child: const Text("Sign Up",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future loginUsers() async {
    if (_loginscreen.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Processing Data"),
          backgroundColor: Colors.green.shade300));
      const Duration(seconds: 5);
      var res = await Api_Client()
          .login(emailController.text, passwordControler.text, 'null')
          .then((value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgetPassword()))
              });
    }
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: const <Widget>[
          buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w500),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }
}

class buildDivider extends StatelessWidget {
  const buildDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Divider(
        color: Color.fromRGBO(0, 0, 0, 1),
        height: 5,
        thickness: 2,
      ),
    );
  }
}
