import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import 'forgetPassword.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signupscreen = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordControler = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
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
            key: _signupscreen,
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
                                builder: (builder) => const LoginScreen()))),
                  ]),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(31, 0, 0, 0),
                  child: Text(
                    "Sign Up",
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
                          controller: nameController,
                          validator: (value) {
                            bool nameValid =
                                RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(value!);
                            if (value.isEmpty) {
                              return "Please enter name";
                            } else if (!nameValid) {
                              return "Please Enter Valid Name";
                            }
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color(0xFF83859C), fontSize: 14),
                            labelText: "Name",
                            labelStyle: TextStyle(
                                color: Color(0xFF83859C), fontSize: 16),
                            border: OutlineInputBorder(
                                gapPadding: 1,
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 210, 1)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 18, 31, 0),
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
                    padding: const EdgeInsets.fromLTRB(35, 18, 31, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            bool phoneValid =
                                RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                    .hasMatch(value!);
                            if (value.isEmpty) {
                              return "Please enter phone number";
                            } else if (phoneValid) {
                              return "Phone number should not be more than 10 characters";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                color: Color(0xFF83859C), fontSize: 14),
                            labelText: "Phone Number",
                            labelStyle: TextStyle(
                                color: Color(0xFF83859C), fontSize: 16),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(199, 200, 210, 1)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ],
                    )),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 15, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: firstValue,
                            checkColor: Colors.black,
                            activeColor: Colors.blue,
                            onChanged: (bool? value1) {
                              setState(
                                () {
                                  firstValue = value1!;
                                },
                              );
                            },
                          ),
                          const Text(
                            "I agree to ",
                            style: TextStyle(
                                color: Color.fromRGBO(43, 43, 67, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Term and Condition",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 18, 31, 0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => {
                          if (_signupscreen.currentState!.validate())
                            {
                              _handleRegisterUser(),
                            }
                        },
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(36, 55, 99, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Create Account",
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
                  padding: const EdgeInsets.fromLTRB(90, 10, 0, 0),
                  child: Row(
                    children: [
                      const Text("Already have an account ?",
                          style: TextStyle(
                              color: Color.fromRGBO(84, 85, 99, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (builder) => const LoginScreen()));
                          },
                          child: const Text("Sign In",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)))
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

  Future<void> _handleRegisterUser() async {
    if (_signupscreen.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Processing Data"),
          backgroundColor: Colors.green.shade300));
      var res = await Api_Client()
          .signup(emailController.text.trim(), passwordControler.text.trim(),
              phoneController.text.trim(), nameController.text.trim())
          .then((value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgetPassword()))
              });
    }
    // // Future.delayed(Duration(milliseconds: 1000), () => AlertDialog(

    // // ));

    // Map<String, dynamic> userData = {
    //   "contactLname": nameController.text,
    //   "email": emailController.text,
    //   "phone": phoneController.text,
    //   "password": passwordControler.text,
    // };
    // // try {
    // var res = await Api_Client().signup(userData);
    // //   print(res);
    // // } catch (e) {
    // //   print(e);
    // // }
    // if (res == 201) {
    //   emailController.clear();
    //   passwordControler.clear();
    //   nameController.clear();
    //   phoneController.clear();
    //   passConfirmController.clear();
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const LoginScreen()));
    // }
    // // checks if there is no error in the response body.
    // // if error is not present, navigate the users to Login Screen.
    // else {
    //   //if error is present, display a snackbar showing the error messsage
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Error'),
    //     backgroundColor: Colors.red.shade300,
    //   ));
    // }
  }
}
