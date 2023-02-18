import 'dart:convert';

import 'package:ecloset/Model/DTO/index.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../utils/routes_name.dart';

class ClosetPage extends StatefulWidget {
  const ClosetPage({Key? key}) : super(key: key);

  @override
  State<ClosetPage> createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  // List<ClosetDTO> closetList = [];
  int id = 1;
  @override
  void initState() {
    super.initState();
    Get.find<ClosetViewModel>().getCloset();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ClosetViewModel(),
      child: ScopedModelDescendant<ClosetViewModel>(
        builder: (context, child, model) {
          bool isEmpty = false;
          if (model.closetList == null || model.closetList!.isEmpty) {
            isEmpty = true;
          }
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
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Material(
                  color: AppColors.primaryColor,
                  child: InkWell(
                    onTap: () async {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios,
                        size: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        isEmpty
                            ? SizedBox()
                            : GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                ),
                                itemCount: model.closetList?.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var closet = model.closetList?[index];
                                  return Card(
                                    child: InkWell(
                                      child: closet?.image == null
                                          ? Image.network(
                                              "https://picsum.photos/200/300",
                                              fit: BoxFit.cover)
                                          : Image.memory(base64Decode(
                                              closet?.image ?? '')),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteName.addEditItemPage,
                                            arguments: closet);
                                      },
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // void fetchClosets() async {
  //   try {
  //     const url = 'https://localhost:7269/api/product/list';
  //     final response = await http.get(Uri.parse(url));
  //     final json = jsonDecode(response.body);
  //     setState(() {
  //       closetList = List<Closet>.from(json.map((i) => Closet.fromJson(i)));
  //     });
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  // }
}
