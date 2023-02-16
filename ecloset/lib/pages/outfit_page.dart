import 'dart:convert';

import 'package:ecloset/constants/app_colors.dart';
import 'package:ecloset/constants/app_styles.dart';
import 'package:ecloset/pages/closet_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/routes_name.dart';

class Outfit {
  final int outfitId;
  final String outfitName;
  final int categoryId;
  final int subcategoryId;
  final int supplierId;
  final String? image;
  final String? description;

  Outfit({
    required this.outfitId,
    required this.outfitName,
    required this.categoryId,
    required this.subcategoryId,
    required this.supplierId,
    this.image,
    this.description,
  });

  static fromJson(i) {
    Outfit c = Outfit(
      outfitName: i['outfitName'],
      outfitId: i['outfitId'],
      categoryId: i['categoryId'],
      subcategoryId: i['subcategoryId'],
      supplierId: i['supplierId'],
      image: i["image"],
      description: i["description"],
    );
    return c;
  }
}

class OutfitPage extends StatefulWidget {
  const OutfitPage({super.key});

  @override
  State<OutfitPage> createState() => _OutfitPageState();
}

class _OutfitPageState extends State<OutfitPage> {
  List<Outfit> outfitList = [];
  int id = 1;
  @override
  void initState() {
    super.initState();
    fetchOutfit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Outfit",
          style: AppStyles.h3,
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            tooltip: "Add new outfit",
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, RouteName.createOutfitPage);
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
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: outfitList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Outfit outfit = outfitList[index];
                    return Card(
                      child: InkWell(
                        child: outfit.image == null
                            ? Image.network("https://picsum.photos/200/300",
                                fit: BoxFit.cover)
                            : Image.memory(base64Decode(outfit.image!)),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.addEditItemPage,
                              arguments: outfit);
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

  void fetchOutfit() async {
    try {
      const url = 'https://10.0.2.2:7269/api/outfit/list';
      // const url = '192.168.0.101/api/outfit/list';
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      setState(() {
        outfitList = List<Outfit>.from(json.map((i) => Outfit.fromJson(i)));
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
