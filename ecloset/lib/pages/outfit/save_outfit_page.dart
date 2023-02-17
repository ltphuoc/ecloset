import 'dart:convert';
import 'dart:io';

import 'package:ecloset/pages/outfit/outfit_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../api/api_client.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../home/home_page.dart';

class SaveOutfitPage extends StatefulWidget {
  SaveOutfitPage({super.key, required this.imageByte});

  dynamic imageByte;

  @override
  _SaveOutfitPageState createState() => _SaveOutfitPageState();
}

class _SaveOutfitPageState extends State<SaveOutfitPage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _nameOfOutfit;
  String? _description;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // title: new Text('Are you sure?'),
            content: const Text(
                'Do you want to leave page now, your outfit will be lost'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Leave'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                  if (_formKey.currentState!.validate()) {
                    saveOutfit(context);
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
                    onChanged: (value) {
                      setState(() {
                        _nameOfOutfit = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
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
      ),
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

      var formData = jsonEncode({
        "outfitName": _nameOfOutfit ?? "Default outfit",
        "categoryId": 0,
        "subcategoryId": 0,
        "supplierId": 0,
        "image": newUrl.toString(),
        "description": _description,
      });

      const url = '$baseUrl/api/outfit/add';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: formData,
      );
      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OutfitPage()),
        );
      }
    });
  }
}
