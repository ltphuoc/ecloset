// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/api/api_client.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/loading_screen.dart';

enum ProductCategories { top, bottom, footwear, otherAccessories }

class SubProductCat {
  int id;
  int catId;
  String name;
  SubProductCat({required this.id, required this.name, required this.catId});
}

class ProductCat {
  int id;
  String name;
  ProductCat({required this.id, required this.name});
}

List<ProductCat> productCategories = [
  ProductCat(id: 1, name: "Shirt"),
  ProductCat(id: 2, name: "Pant"),
  ProductCat(id: 3, name: "Foot Wear"),
  ProductCat(id: 4, name: "Other Accessories"),
];
List<SubProductCat> subProductCategories = [
  SubProductCat(id: 1, name: "T-Shirt", catId: 1),
  SubProductCat(id: 1, name: "Polo", catId: 2),
  SubProductCat(id: 1, name: "Shirt", catId: 3),
  SubProductCat(id: 1, name: "Jacket", catId: 4),
  SubProductCat(id: 1, name: "Hoodie", catId: 5),
  SubProductCat(id: 1, name: "Sweater", catId: 6),
  SubProductCat(id: 1, name: "Blazer", catId: 7),
  SubProductCat(id: 2, name: "Short", catId: 8),
  SubProductCat(id: 2, name: "Trousers", catId: 9),
  SubProductCat(id: 2, name: "Jeans", catId: 10),
  SubProductCat(id: 2, name: "Khaki", catId: 11),
  SubProductCat(id: 2, name: "Cargo", catId: 12),
  SubProductCat(id: 3, name: "Trainers", catId: 13),
  SubProductCat(id: 3, name: "Sneakers", catId: 14),
  SubProductCat(id: 3, name: "Boots", catId: 15),
  SubProductCat(id: 3, name: "Sandals", catId: 16),
  SubProductCat(id: 4, name: "Hat", catId: 17),
  SubProductCat(id: 4, name: "Glasses", catId: 18),
  SubProductCat(id: 4, name: "Belt", catId: 19),
  SubProductCat(id: 4, name: "Wallet", catId: 20),
];

class AddEditItemPage extends StatefulWidget {
  const AddEditItemPage({super.key, this.id});

  final int? id;

  @override
  State<AddEditItemPage> createState() => _AddEditItemPageState();
}

class _AddEditItemPageState extends State<AddEditItemPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  int? productId;
  int? _productCatId;
  int? _subProductCatId;
  String? _productName;
  File? image;
  Uint8List? imageFile;
  String? imagePath;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future pickImage(context) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (image == null) return;

      imagePath = image.path;
      imageFile = await image.readAsBytes();
      this.image = File(image.path);
      setState(() {});
    } on Exception catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _isEdit = widget.id != null;
    if (widget.id != null) {
      Get.find<ClosetViewModel>().getCloset(widget.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: ClosetViewModel(),
        child: ScopedModelDescendant<ClosetViewModel>(
            builder: (context, child, model) {
          var closetItem = Get.find<ClosetViewModel>().closet;

          if (closetItem != null && _isEdit) {
            productId = closetItem.productId;
            _productCatId = closetItem.categoryId;
            _subProductCatId = closetItem.subcategoryId;
            _productName = closetItem.productName;
          }

          return Scaffold(
            backgroundColor: AppColors.whiteBg,
            appBar: AppBar(
              title: _isEdit
                  ? const Text("Edit clothes")
                  : const Text("Add new clothes"),
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
              actions: [
                if (_isEdit)
                  IconButton(
                    onPressed: () async {
                      bool shouldDelete = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: const Text(
                                "Are you sure you want to delete this item?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                      if (shouldDelete == true) {
                        loadingScreen(context);
                        bool isSuccess = await Get.find<ClosetViewModel>()
                            .deleteCloset(productId!);
                        Navigator.of(context).pop();
                        if (isSuccess) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Delete Failed")),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.delete),
                  )
              ],
            ),
            bottomNavigationBar: _productName != null &&
                    _productName != "" &&
                    _subProductCatId != null
                ? ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            AppColors.secondaryColor)),
                    child: Text(
                      "Save",
                      style:
                          AppStyles.h4.copyWith(color: AppColors.primaryColor),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ClosetViewModel root = Get.find<ClosetViewModel>();
                        String newUrl = _isEdit ? closetItem?.image ?? "" : "";

                        if (imagePath != null) {
                          imageFile = await ApiCLient().removeBgApi(imagePath!);

                          setState(() {});

                          firebase_storage.Reference ref =
                              firebase_storage.FirebaseStorage.instance.ref(
                                  "/foldername${DateTime.now().millisecondsSinceEpoch}");

                          final TaskSnapshot snapshot =
                              await ref.putData(imageFile!);

                          newUrl = await snapshot.ref.getDownloadURL();
                        }

                        if (_isEdit) {
                          root.updateCloset(productId!, _productName!,
                              _productCatId!, _subProductCatId!, newUrl);
                        } else {
                          root.addCloset(
                              _productName as String,
                              _productCatId as int,
                              _subProductCatId as int,
                              newUrl);
                        }
                      }
                    },
                  )
                : null,
            body: SingleChildScrollView(
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
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1.5, color: AppColors.primaryColor)),
                            height: 350,
                            width: double.infinity,
                            child: _isEdit
                                ? Image.network(
                                    closetItem?.image ??
                                        'https://picsum.photos/300',
                                    fit: BoxFit.fill)
                                : image != null
                                    ? Image.file(
                                        image!,
                                        fit: BoxFit.fitHeight,
                                      )
                                    : Center(
                                        child: Text(
                                        "Upload your item",
                                        style: AppStyles.h4.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ))),
                        onTap: () => pickImage(context),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Name",
                        style: AppStyles.h4
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        initialValue: _productName,
                        onChanged: ((value) => setState(() {
                              _productName = value;
                            })),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.textWhite,
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.primaryColor, width: 1.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorStyle: const TextStyle(height: 0),
                          counterText: "",
                        ),
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
                        "Type of clothes",
                        style: AppStyles.h4
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                          validator: (value) =>
                              value == null ? "Please select" : null,
                          value: _productCatId,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.textWhite,
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0.0,
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.primaryColor, width: 1.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorStyle: const TextStyle(height: 0),
                            counterText: "",
                          ),
                          items: productCategories
                              .map((e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name.toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _productCatId = value;
                            });
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Category",
                        style: AppStyles.h4
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownButtonFormField(
                          validator: (value) =>
                              value == null ? "Please select" : null,
                          value: _subProductCatId,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.textWhite,
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0.0,
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.primaryColor, width: 1.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorStyle: const TextStyle(height: 0),
                            counterText: "",
                          ),
                          items: subProductCategories
                              .where((e) => e.id == _productCatId)
                              .map((e) => DropdownMenuItem(
                                    value: e.catId,
                                    child: Text(e.name.toString()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _subProductCatId = value;
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
