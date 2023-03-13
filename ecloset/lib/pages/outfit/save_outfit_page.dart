// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/widgets/loading_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_styles.dart';

class SaveOutfitPage extends StatefulWidget {
  SaveOutfitPage({super.key, required this.imageByte});

  dynamic imageByte;

  @override
  _SaveOutfitPageState createState() => _SaveOutfitPageState();
}

class _SaveOutfitPageState extends State<SaveOutfitPage> {
  String? outfitName;
  // String? value;
  // TextEditingController controller = TextEditingController(text: value);
  String? description;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Outfit idea",
          style: AppStyles.h3,
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  loadingScreen(context);
                  firebase_storage.Reference ref =
                      firebase_storage.FirebaseStorage.instance.ref(
                          "/foldername${DateTime.now().millisecondsSinceEpoch}");
                  final tempDir = await getTemporaryDirectory();
                  File file = await File('${tempDir.path}/image.png').create();
                  final TaskSnapshot snapshot =
                      await ref.putData(widget.imageByte);
                  var newUrl = await snapshot.ref.getDownloadURL();
                  ClosetViewModel root = Get.find<ClosetViewModel>();
                  Navigator.pop(context);
                  await root.saveOutfit(
                      outfitName as String, newUrl, description as String);
                }
              },
              child: Text(
                "Save",
                style: AppStyles.h5,
              ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: InkWell(
                    child: AspectRatio(
                      aspectRatio: 366 / 512,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryColor, width: 1.5)),
                        width: double.infinity,
                        child: Image.memory(widget.imageByte),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Name of your outfit",
                  style: AppStyles.h4.copyWith(color: AppColors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: outfitName as TextEditingController,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: AppColors.textWhite,
                    errorStyle: const TextStyle(height: 0),
                    counterText: "",
                  ),
                  autofocus: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Note (optional)",
                  style: AppStyles.h4.copyWith(color: AppColors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: description as TextEditingController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 6,
                  minLines: 3,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: AppColors.textWhite,
                    errorStyle: const TextStyle(height: 0),
                    counterText: "",
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  // void saveOutfit(context) async {
  //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
  //       .ref("/foldername${DateTime.now().millisecondsSinceEpoch}");
  //   final tempDir = await getTemporaryDirectory();
  //   File file = await File('${tempDir.path}/image.png').create();
  //   file.writeAsBytesSync(widget.imageByte);
  //   firebase_storage.UploadTask uploadTask = ref.putFile(file.absolute);

  //   Future.value(uploadTask).then((value) async {
  //     var newUrl = await ref.getDownloadURL();
  //     print(newUrl);
  //   });
  // }
}
