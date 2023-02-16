import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../constant/app_colors.dart';
import '../constant/app_styles.dart';

class SaveOutfitPage extends StatefulWidget {
  SaveOutfitPage({super.key, required this.imageByte});

  dynamic imageByte;

  @override
  _SaveOutfitPageState createState() => _SaveOutfitPageState();
}

class _SaveOutfitPageState extends State<SaveOutfitPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.imageByte);
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Outfit idea",
          style: AppStyles.h3,
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
                saveOutfit(context);
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
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    color: Colors.white,
                    child: Image.memory(widget.imageByte, fit: BoxFit.fill),
                  ),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "Name of your outfit",
                  style: AppStyles.h4,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: AppColors.textWhite,
                      errorStyle: const TextStyle(height: 0),
                      counterText: "",
                      filled: true),
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
                  style: AppStyles.h4,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: AppColors.textWhite,
                      errorStyle: const TextStyle(height: 0),
                      counterText: "",
                      filled: true),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void saveOutfit(context) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref("/foldername${DateTime.now().millisecondsSinceEpoch}");
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(widget.imageByte);
    firebase_storage.UploadTask uploadTask = ref.putFile(file.absolute);

    Future.value(uploadTask).then((value) async {
      var newUrl = await ref.getDownloadURL();
      print(newUrl);
    });
  }
}
