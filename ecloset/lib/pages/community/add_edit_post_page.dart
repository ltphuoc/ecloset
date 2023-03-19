// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecloset/utils/request.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Constant/app_colors.dart';
import '../../ViewModel/account_viewModel.dart';
import '../../constant/app_styles.dart';
import '../../utils/shared_pref.dart';
import '../../widgets/loading_screen.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _postController = TextEditingController();
  File? _image;
  String? _imagePath;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imagePath = pickedFile.path;
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var account = Get.find<AccountViewModel>().account;
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: AppBar(
        title: const Text("Add post"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          Container(
              margin:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 4),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Color.fromARGB(132, 217, 217, 217),
                    backgroundColor: AppColors.brown,
                    disabledBackgroundColor:
                        const Color.fromARGB(132, 217, 217, 217),
                  ),
                  onPressed: _postController.text.trim() != "" || _image != null
                      ? () async {
                          try {
                            String? newUrl;
                            if (_imagePath != null) {
                              firebase_storage.Reference ref =
                                  firebase_storage.FirebaseStorage.instance.ref(
                                      "/foldername${DateTime.now().millisecondsSinceEpoch}");

                              final TaskSnapshot snapshot =
                                  await ref.putFile(_image!);

                              newUrl = await snapshot.ref.getDownloadURL();
                            }
                            loadingScreen(context);

                            var accountId = await getAccountId()
                                .then((value) => int.parse(value!));
                            final res = await request.post("api/Post", data: {
                              "postContent": _postController.text.trim(),
                              "accountId": accountId,
                              "postImg": newUrl ?? ""
                            });
                            Navigator.of(context).pop();
                            if (res.statusCode != 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Can't post. Please try again")),
                              );
                            } else {
                              const SnackBar(content: Text("Posted"));
                              // Navigator.pop(context);
                            }
                          } catch (e) {
                            if (kDebugMode) {
                              print(e.toString());
                            }
                          }
                        }
                      : null,
                  child: const Text("Post")))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(account?.avatar ?? ""),
                ),
                title: Text(
                  "${account!.contactFname ?? ""} ${account.contactLname ?? ""}"
                      .trim(),
                  style: AppStyles.h4.copyWith(color: Colors.black),
                ),
                subtitle: Text(
                  account.email ?? "",
                  style: AppStyles.h5.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                trailing: IconButton(
                  color: AppColors.black,
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: _getImageFromGallery,
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _postController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Write something'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      color: AppColors.greyBg,
                      child: Center(
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.contain,
                              )
                            : const SizedBox.shrink(),
                      ),
                    )
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
