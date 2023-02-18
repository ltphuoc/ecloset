import 'dart:io';

import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on Exception catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Profile Setting",
          style: AppStyles.h3,
        ),
      ),
      backgroundColor: AppColors.whiteBg,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    decoration: image != null
                        ? BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // radius of 10
                            image: DecorationImage(
                                image: FileImage(image!), fit: BoxFit.cover),
                          )
                        : BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // radius of 10
                            color: AppColors.textWhite,
                          ),
                    height: 100,
                    width: 100,
                    child: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileField(
                            title: "Nickname", value: "nickname"),
                      ));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nickname",
                        style: AppStyles.h4.copyWith(
                            letterSpacing: 1.3, color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("nickname",
                          style: AppStyles.h5.copyWith(
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1.3,
                              color: AppColors.black)),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: AppColors.black,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              //   InkWell(
              //     onTap: () {},
              //     child: Container(
              //       width: double.infinity,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Nickname",
              //             style: AppStyles.h4.copyWith(letterSpacing: 1.3),
              //           ),
              //           const SizedBox(
              //             height: 4,
              //           ),
              //           Text("nickname",
              //               style: AppStyles.h5.copyWith(
              //                   fontWeight: FontWeight.normal,
              //                   letterSpacing: 1.3)),
              //           const SizedBox(
              //             height: 8,
              //           ),
              //           const Divider(
              //             color: AppColors.textWhite,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileField extends StatefulWidget {
  const EditProfileField({super.key, required this.title, required this.value});

  final String title, value;

  @override
  State<EditProfileField> createState() => _EditProfileFieldState();
}

class _EditProfileFieldState extends State<EditProfileField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        final isValid = _formKey.currentState!.validate();
        if (_isValid != isValid) {
          setState(() {
            _isValid = isValid;
          });
        }
      },
      child: Scaffold(
        bottomNavigationBar: _isValid
            ? ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(AppColors.primaryColor),
                ),
                child: Text(
                  "Save",
                  style: AppStyles.h4.copyWith(color: AppColors.textWhite),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
              )
            : ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(AppColors.textGrey),
                ),
                onPressed: null,
                child: Text(
                  "Save",
                  style: AppStyles.h4.copyWith(color: AppColors.textWhite),
                )),
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
            title: Text(
              widget.title,
            )),
        backgroundColor: AppColors.whiteBg,
        body: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: Column(children: [
            TextFormField(
              autofocus: true,
              maxLength: 15,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  fillColor: AppColors.textWhite,
                  errorStyle: TextStyle(height: 0),
                  counterText: "",
                  filled: true),
              initialValue: widget.value,
              validator: (String? value) {
                RegExp regExp = RegExp(r'^[a-z0-9]{5,15}$');
                return regExp.hasMatch(value!) ? null : "";
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                "Nickname can only use 5-15 lower case letters, numbers.",
                style: AppStyles.h5.copyWith(
                    fontWeight: FontWeight.normal,
                    color: _isValid ? Colors.black : Colors.red),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
