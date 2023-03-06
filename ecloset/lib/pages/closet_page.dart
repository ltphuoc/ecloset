import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:ecloset/Model/DTO/ClosetDTO.dart';
import 'package:ecloset/ViewModel/closet_viewModel.dart';
import 'package:ecloset/constant/app_colors.dart';
import 'package:ecloset/constant/app_styles.dart';
import 'package:ecloset/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';

class SubCat {
  int id;
  String name;

  SubCat({required this.id, required this.name});
}

List<SubCat> cat = [
  SubCat(id: 1, name: "Top"),
  SubCat(id: 2, name: "Pant"),
  SubCat(id: 3, name: "Footwear"),
  SubCat(id: 4, name: "Accessories"),
];

List<SubCat> topBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 1, name: "T-Shirt"),
  SubCat(id: 2, name: "Polo"),
  SubCat(id: 3, name: "Shirt"),
  SubCat(id: 4, name: "Jacket"),
  SubCat(id: 5, name: "Hoodie"),
  SubCat(id: 6, name: "Sweater"),
  SubCat(id: 7, name: "Blazer"),
];
List<SubCat> pantBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 8, name: "Short"),
  SubCat(id: 9, name: "Trousers"),
  SubCat(id: 10, name: "Jeans"),
  SubCat(id: 11, name: "Khaki"),
  SubCat(id: 12, name: "Cargo"),
];
List<SubCat> footwearBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 13, name: "Trainers"),
  SubCat(id: 14, name: "Sneakers"),
  SubCat(id: 15, name: "Boots"),
  SubCat(id: 16, name: "Sandals"),
];
List<SubCat> otherBtn = [
  SubCat(id: 0, name: "All"),
  SubCat(id: 17, name: "Hat"),
  SubCat(id: 18, name: "Glasses"),
  SubCat(id: 19, name: "Belt"),
  SubCat(id: 20, name: "Wallet"),
];

String getNameById(int id, List<SubCat> list) {
  for (var subCat in list) {
    if (subCat.id == id) {
      return subCat.name;
    }
  }
  return "";
}

class ClosetPage extends StatefulWidget {
  const ClosetPage({Key? key}) : super(key: key);

  @override
  State<ClosetPage> createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  int id = 1;
  int? _selectedTop;
  int? _selectedPant;
  int? _selectedFootwear;
  int? _selectedOther;
  @override
  void initState() {
    super.initState();
    Get.find<ClosetViewModel>().getCloset();
    _selectedTop = topBtn.first.id;
    _selectedPant = topBtn.first.id;
    _selectedFootwear = topBtn.first.id;
    _selectedOther = topBtn.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ClosetViewModel(),
      child: ScopedModelDescendant<ClosetViewModel>(
        builder: (context, child, model) {
          var closetList = Get.find<ClosetViewModel>().closetList ?? [];
          List topIds, pantIds, footwearIds, otherIds;
          List categoryIds =
              closetList.map((closet) => closet.categoryId).toSet().toList();
          List subCategoryIds =
              closetList.map((closet) => closet.subcategoryId).toSet().toList();
          if (categoryIds.isNotEmpty) {
            categoryIds.add(0);
            categoryIds = categoryIds.toList()..sort();
          }
          if (subCategoryIds.isNotEmpty) {
            subCategoryIds.add(0);
            subCategoryIds = subCategoryIds.toList()..sort();
          }
          topIds = subCategoryIds.where((e) => e <= 7).toList();
          pantIds = subCategoryIds
              .where((e) => (e <= 12 && e >= 8) || e == 0)
              .toList();
          footwearIds = subCategoryIds
              .where((e) => (e <= 16 && e >= 13) || e == 0)
              .toList();
          otherIds = subCategoryIds
              .where((e) => (e <= 20 && e >= 17) || e == 0)
              .toList();
          if (closetList.isEmpty) {}
          return Scaffold(
            backgroundColor: AppColors.whiteBg,
            appBar: const MainAppBar(),
            body: SafeArea(
                child: DefaultTabController(
              length: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 8),
                    width: Get.width,
                    child: const TabBar(
                      isScrollable: true,
                      indicatorColor: AppColors.primaryColor,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "Top",
                        ),
                        Tab(
                          text: "Pant",
                        ),
                        Tab(
                          text: "Footwear",
                        ),
                        Tab(
                          text: "Accessories",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        GridView.count(
                            crossAxisCount: 3,
                            children: closetList
                                .map((e) => closetItemCard(e))
                                .toList()),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: topIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: topIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, topBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: topIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 1;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: pantIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: pantIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, pantBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: pantIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 2;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: footwearIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: footwearIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, footwearBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: footwearIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 3;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                        DefaultTabController(
                            animationDuration: Duration.zero,
                            length: otherIds.length,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TabBar(
                                      indicatorColor: Colors.transparent,
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      isScrollable: true,
                                      tabs: otherIds.map((e) {
                                        return Tab(
                                          text: getNameById(e, otherBtn),
                                        );
                                      }).toList()),
                                ),
                                Expanded(
                                  child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: otherIds.map((subCatId) {
                                        return GridView.count(
                                            crossAxisCount: 3,
                                            children: closetList
                                                .where((e) {
                                                  if (subCatId != 0) {
                                                    return e.subcategoryId ==
                                                        subCatId;
                                                  }
                                                  return e.categoryId == 4;
                                                })
                                                .map((e) => closetItemCard(e))
                                                .toList());
                                      }).toList()),
                                )
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  InkWell closetItemCard(ClosetData e) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 0.1),
        ),
        child: Image.network(
          e.image ?? 'https://picsum.photos/300',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
