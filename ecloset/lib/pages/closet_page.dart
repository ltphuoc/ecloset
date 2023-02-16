import 'dart:convert';

import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/routes_name.dart';

class Closet {
  final int productId;
  final int categoryId;
  final int subcategoryId;
  final int supplierId;
  final String productName;
  final String? color;
  final String? image;
  final String? productUrl;
  final String? subcategory;
  final String? supplier;

  Closet(
      {required this.productId,
      required this.categoryId,
      required this.subcategoryId,
      required this.supplierId,
      required this.productName,
      this.color,
      this.image,
      this.productUrl,
      this.subcategory,
      this.supplier});

  static fromJson(i) {
    Closet c = Closet(
      productName: i['productName'],
      productId: i['productId'],
      categoryId: i['categoryId'],
      subcategoryId: i['subcategoryId'],
      supplierId: i['supplierId'],
      color: i["color"],
      image: i["image"],
      productUrl: i["productUrl"],
      subcategory: i["subcategory"],
      supplier: i["supplier"],
    );
    return c;
  }
}

class ClosetPage extends StatefulWidget {
  ClosetPage({super.key});

  @override
  State<ClosetPage> createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  List<Closet> closetList = [];
  int id = 1;
  @override
  void initState() {
    super.initState();
    fetchClosets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Closet",
          style: AppStyles.h3,
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            tooltip: "Add new item",
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, RouteName.addEditItemPage);
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: closetList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Closet closet = closetList[index];
                    return Card(
                      child: InkWell(
                        child: closet.image == null
                            ? Image.network("https://picsum.photos/200/300",
                                fit: BoxFit.cover)
                            : Image.memory(base64Decode(closet.image!)),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.addEditItemPage,
                              arguments: closet);
                        },
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void fetchClosets() async {
    try {
      const url = 'https://localhost:7269/api/product/list';
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      setState(() {
        closetList = List<Closet>.from(json.map((i) => Closet.fromJson(i)));
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
