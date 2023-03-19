// ignore_for_file: use_build_context_synchronously

import 'package:ecloset/widgets/loading_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import '../../Model/DTO/OutFitDTO.dart';
import '../../Utils/request.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_styles.dart';

class EditOutfitPage extends StatefulWidget {
  EditOutfitPage({super.key, required this.id});

  final int? id;

  @override
  State<EditOutfitPage> createState() => _EditOutfitPageState();
}

class _EditOutfitPageState extends State<EditOutfitPage> {
  String? outfitName;
  String? description;
  OutFitDTO? outfit;
  TextEditingController outfitNameController = TextEditingController();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    outfitNameController.dispose();
    super.dispose();
  }

  Future<void> fetchOutfit() async {
    try {
      final res = await request.get("api/Outfit/${widget.id}");

      final jsonList = res.data['data'];

      if (jsonList != null) {
        outfit = OutFitDTO.fromJson(jsonList);
        outfitName = outfit!.outfitName.toString();
      }

      setState(() {});
    } catch (e) {
      print("Error fetching posts: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOutfit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit outfit",
          style: AppStyles.h3,
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    loadingScreen(context);
                    final res = await request
                        .put("api/Outfit/${outfit!.outfitId}", data: {
                      "outfitName": outfitName?.trim(),
                      "categoryId": outfit!.categoryId,
                      "subcategoryId": outfit!.subcategoryId,
                      "supplierId": outfit!.supplierId,
                      "image": outfit!.image,
                      "description": outfit!.description
                    });
                    Navigator.of(context).pop();
                    if (res.statusCode != 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Update Failed")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Updated")),
                      );
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Delete Failed.Please try again")),
                    );
                  }
                }
              },
              child: Text(
                "Save",
                style: AppStyles.h5,
              ))
        ],
      ),
      body: outfit == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                      color: AppColors.primaryColor,
                                      width: 1.5)),
                              width: double.infinity,
                              child: Image.network(outfit!.image!),
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
                        initialValue: outfitName,
                        onChanged: (value) {
                          outfitName = value;
                          setState(() {});
                        },
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
