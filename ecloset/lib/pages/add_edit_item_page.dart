import 'dart:io';
import 'dart:typed_data';

import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/api/api_client.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  const AddEditItemPage({
    super.key,
    required this.closet,
  });

  final ClosetData closet;

  @override
  State<AddEditItemPage> createState() => _AddEditItemPageState();
}

class _AddEditItemPageState extends State<AddEditItemPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  int? _productId;
  int? _subProductCat;
  String? _productName;
  File? image;
  Uint8List? imageFile;
  String? imagePath;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  // DatabaseReference databaseRef = FirebaseDatabase.instance.ref("Image");

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
    _isEdit = widget.closet != null;
    // _productCat = widget.closet?.categoryId;
    // _subProductCat = widget.closet?.subcategoryId;
    // _productName = widget.closet?.productName;
  }

  void saveItem(context) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref("/foldername${DateTime.now().millisecondsSinceEpoch}");
    firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);

    Future.value(uploadTask).then((value) async {
      var newUrl = await ref.getDownloadURL();
      // var formData = jsonEncode({
      //   "productName": _productName,
      //   "categoryId": _productCat,
      //   "subcategoryId": _subProductCat,
      //   "supplierId": 1,
      //   "color": "string",
      //   "image": newUrl,
      //   "productUrl": "string"
      // });

      // const url = 'https://localhost:7269/api/product/add';
      // final response = await http.post(
      //   Uri.parse(url),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: formData,
      // );
      // if (response.statusCode == 201) {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => const HomePage()),
      //       (route) => false);
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ClosetPage()),
      //   );
      // }
    });
  }

  // void deleteItem(context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return AlertDialog(
  //           title: const Text('Please Confirm'),
  //           content: const Text('Are you sure to remove this item?'),
  //           actions: [
  //             TextButton(
  //                 onPressed: () async {
  //                   var url =
  //                       "https://localhost:7269/api/product/${widget.closet?.productId}";
  //                   final response = await http.delete(Uri.parse(url));
  //                   if (response.statusCode == 200) {
  //                     Navigator.pushNamedAndRemoveUntil(
  //                         context, RouteName.app, (route) => false);
  //                     Navigator.pushNamed(
  //                       context,
  //                       RouteName.closetPage,
  //                     );
  //                   } else {
  //                     Navigator.of(context).pop();
  //                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //                         content:
  //                             Text('Failed to delete item, please try again')));
  //                   }
  //                 },
  //                 child: const Text('Yes')),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('No'))
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: AppBar(
        title: const Text("Add new clothes"),
        centerTitle: true,
        // leading: ,
        backgroundColor: AppColors.primaryColor,
        actions: [
          if (_isEdit)
            IconButton(
                onPressed: () {
                  // deleteItem(context);
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      bottomNavigationBar: _productId != null &&
              _productName != null &&
              _productName != "" &&
              _subProductCat != null
          ? ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      AppColors.secondaryColor)),
              child: Text(
                "Save",
                style: AppStyles.h4.copyWith(color: AppColors.black),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ClosetViewModel root = Get.find<ClosetViewModel>();
                  imageFile = await ApiCLient().removeBgApi(imagePath!);
                  setState(() {});

                  firebase_storage.Reference ref =
                      firebase_storage.FirebaseStorage.instance.ref(
                          "/foldername${DateTime.now().millisecondsSinceEpoch}");
                  // firebase_storage.UploadTask uploadTask =
                  //     ref.putFile(image!.absolute);
                  final TaskSnapshot snapshot = await ref.putData(imageFile!);

                  var newUrl = await snapshot.ref.getDownloadURL();
                  root.addCloset(_productName as String, _productId as int,
                      _subProductCat as int, newUrl);
                }
              },
            )
          : null,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 16,
                // ),
                // Text(
                //   _isEdit ? "Edit item" : "Add new item",
                //   style: AppStyles.h2.copyWith(color: AppColors.black),
                // ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  child: Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.white,
                      child: _isEdit
                          ? Image.network(
                              widget.closet?.image ??
                                  'https://picsum.photos/300',
                              fit: BoxFit.cover)
                          : image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.fitHeight,
                                )
                              : Center(
                                  child: Text(
                                  "Upload your item",
                                  style: AppStyles.h4.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ))),
                  onTap: () => pickImage(context),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "Name",
                  style: AppStyles.h4.copyWith(color: AppColors.black),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue: _productName,
                  onChanged: ((value) => setState(() {
                        _productName = value;
                      })),
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
                  "Type of clothes",
                  style: AppStyles.h4.copyWith(color: AppColors.black),
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? "Please select" : null,
                    value: _productId,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: AppColors.textWhite,
                        errorStyle: const TextStyle(height: 0),
                        counterText: "",
                        filled: true),
                    items: productCategories
                        .map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _productId = value;
                      });
                    }),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Category",
                  style: AppStyles.h4.copyWith(color: AppColors.black),
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? "Please select" : null,
                    value: _subProductCat,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: AppColors.textWhite,
                        errorStyle: const TextStyle(height: 0),
                        counterText: "",
                        filled: true),
                    items: subProductCategories
                        .where((e) => e.id == _productId)
                        .map((e) => DropdownMenuItem(
                              value: e.catId,
                              child: Text(e.name.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _subProductCat = value;
                      });
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
